class_name Player extends CharacterBody2D

enum Rotation {FRONT, DIAGONAL_FRONT, SIDE, DIAGONAL_BACK, BACK}
enum Direction {UP, RIGHT, DOWN, LEFT}
enum VisionStyle {NONE, CIRCLE, CONE}

@export var move_speed: int = 60
@export var rotation_speed: float = 180 * PI / 180
@export var enable_input: int = true
@export var vision_style: VisionStyle = VisionStyle.CONE:
	set(value):
		vision_style = value
		%Vision.texture = vision_texture[value]
@export var walk_sound: AudioStream = preload("res://assets/audios/footstep_wood.wav"):
	set(value):
		walk_sound = value
		$FootstepSound.stream = value

@onready var joystick: TouchScreenButton = $/root.find_child('Joystick', true, false) if OS.get_name() in ['Android', 'iOS'] else null
@onready var animation: AnimatedSprite2D = %Animation
@onready var vision: PointLight2D= %Vision
@onready var state_machine: StateMachine = %StateMachine
@onready var footstep_sound: AudioStreamPlayer2D = $FootstepSound

var head_rotation: float = 1/2 * PI:
	set = _on_rotated
var dir: int = 0
var rotation_state: Rotation = 0
var horizontal_heading: Direction = Direction.LEFT
var vision_texture: Array[Variant] = [
	null,
	preload("res://assets/images/light-circular.png"),
	preload('res://assets/images/light-cone.png')
]
var music_area_array: Array[MusicArea] = []

func _ready():
	velocity = Vector2.ZERO
	vision_style = vision_style
	%Vision.show()
	walk_sound = walk_sound

func _process(delta):
	dir = 0
	if enable_input:
		match OS.get_name():
			'Android', 'iOS':
				head_rotation = joystick.joystick_angle
				dir = joystick.get_joystick_dir().length()
			'Windows', 'macOS':
				if Input.is_action_pressed('rotate_left'):
					head_rotation -= rotation_speed * delta
				if Input.is_action_pressed('rotate_right'):
					head_rotation += rotation_speed * delta
				if Input.is_action_pressed('move_front'): dir = 1

func _on_rotated(value: float) -> void:
	head_rotation = value
	var _rotation: int = int(head_rotation * 180 / PI) % 360
	if _rotation < 0:
		_rotation += 360

	if _rotation < 22.5 or _rotation > 337.5:
		rotation_state = Rotation.SIDE
	elif _rotation < 67.5:
		rotation_state = Rotation.DIAGONAL_FRONT
	elif _rotation < 112.5:
		rotation_state = Rotation.FRONT
	elif _rotation < 157.5:
		rotation_state = Rotation.DIAGONAL_FRONT
	elif _rotation < 202.5:
		rotation_state = Rotation.SIDE
	elif _rotation < 247.5:
		rotation_state = Rotation.DIAGONAL_BACK
	elif _rotation < 292.5:
		rotation_state = Rotation.BACK
	elif _rotation < 337.5:
		rotation_state = Rotation.DIAGONAL_BACK

	horizontal_heading = Direction.LEFT
	if _rotation > 270 or _rotation < 90:
		horizontal_heading = Direction.RIGHT
	
	%Vision.rotation = head_rotation

func _on_area_2d_body_entered(body: TileMapLayer) -> void:
	if body.is_in_group('wall'):
		body.modulate = Color(1, 1, 1, .2)

func _on_area_2d_body_exited(body: TileMapLayer) -> void:
		body.modulate = Color(1, 1, 1, 1)

func _play_footstep_sound():
	footstep_sound.pitch_scale = randf_range(.8, 1.2)
	footstep_sound.play()

func move_to(target_position: Vector2, _move_speed: int = move_speed, state: String = 'Walk') -> Signal:
	assert(state_machine.get_node(state) is PlayerWalk)
	state_machine.enter(state, { 'target_position': target_position, 'move_speed': _move_speed })
	return state_machine.state.finished

func phone_call() -> void:
	state_machine.enter('DropPackage')
	await state_machine.state.finished
	state_machine.enter('Call')

func phone_down() -> void:
	%StateMachine/Call.finished.emit('Idle')
