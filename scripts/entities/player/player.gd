class_name Player extends CharacterBody2D

enum Rotation {FRONT, DIAGONAL_FRONT, SIDE, DIAGONAL_BACK, BACK}
enum Direction {UP, RIGHT, DOWN, LEFT}
enum VisionStyle {NONE, CIRCLE, CONE}

const WALK_SOUND = {
	'wood': preload('res://assets/audios/footstep_wood.mp3'),
	'grass': preload('res://assets/audios/footstep_grass.mp3')
}

@export var move_speed: int = 60
@export var rotation_speed: float = 180 * PI / 180
@export var input_enabled: bool = true
@export var vision_style: VisionStyle = VisionStyle.NONE:
	set(value):
		vision_style = value
		%Vision.texture = vision_texture[value]
@export var walk_sound: AudioStream = preload("res://assets/audios/footstep_wood.mp3"):
	set(value):
		walk_sound = value
		$FootstepSound.stream = value
@onready var joystick: TouchScreenButton = get_node_or_null('../MobileControls/Joystick') if OS.get_name() in ['Android', 'iOS'] else null
@onready var animation: AnimatedSprite2D = %Animation
@onready var vision: PointLight2D = %Vision
@onready var state_machine: StateMachine = %StateMachine
@onready var footstep_sound: AudioStreamPlayer2D = $FootstepSound

var head_rotation: float = 1.0/2 * PI:
	set = _on_rotated
var speed: int = 0
var rotation_state: Rotation = Rotation.FRONT
var horizontal_heading: Direction = Direction.LEFT
var vision_texture: Array[Variant] = [
	null,
	preload("res://assets/images/vfx/light-circular.png"),
	preload('res://assets/images/vfx/light-cone.png')
]
var music_area_array: Array[MusicArea] = []
var state: Variant:
	set(value):
		if value is Array:
			state_machine.enter(value[0], value[1])
		elif value is String:
			state_machine.enter(value)
	get:
		return state_machine.state.name
var world_position: Variant:
	set = set_world_position, get = get_world_position

func _ready():
	velocity = Vector2.ZERO
	vision_style = vision_style
	%Vision.show()
	walk_sound = walk_sound

func _process(delta):
	speed = 0
	if input_enabled:
		#region Move Control
		match OS.get_name():
			'Android', 'iOS':
				head_rotation = joystick.joystick_angle
				speed = joystick.get_joystick_dir().length()
			'Windows', 'macOS':
				if Input.is_action_pressed('move_left'):
					speed = 1
					head_rotation = 1.0 * PI
					if Input.is_action_pressed('move_up'):
						head_rotation += .25 * PI
					elif Input.is_action_pressed('move_down'):
						head_rotation -= .25 * PI
				elif Input.is_action_pressed('move_right'):
					speed = 1
					head_rotation = 0
					if Input.is_action_pressed('move_up'):
						head_rotation -= .25 * PI
					elif Input.is_action_pressed('move_down'):
						head_rotation += .25 * PI
				elif Input.is_action_pressed('move_up'):
					speed = 1
					head_rotation = 1.5 * PI
				elif Input.is_action_pressed('move_down'):
					speed = 1
					head_rotation = .5 * PI
		#endregion
		
		if Input.is_action_just_pressed("interact", true):
			var ov_areas: Array[Area2D] = %ActionArea.get_overlapping_areas()
			if ov_areas.size() > 0:
				var closest_item: Area2D = ov_areas.front()
				if closest_item is Item:
					closest_item.pick_up()
				elif closest_item is StaticItem:
					closest_item.interact()

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
	%ActionArea.rotation = head_rotation

func _on_area_2d_body_entered(body: TileMapLayer) -> void:
	if body.is_in_group('wall'):
		body.modulate = Color(1, 1, 1, .2)

func _on_area_2d_body_exited(body: TileMapLayer) -> void:
		body.modulate = Color(1, 1, 1, 1)

func _play_footstep_sound():
	footstep_sound.pitch_scale = randf_range(.8, 1.2)
	footstep_sound.play()

func get_world_position():
	return global_position

func set_world_position(value: Variant):
	var scene: Node
	if value is Vector2:
		global_position = value
	if value == null:
		value = 'Spawn'
	if value is Array:
		scene = value[1]
		if value[0] is String:
			value = value[0]
	if value is String:
		if not scene:
			scene = get_tree().current_scene
		var entrances: Array = scene.get_node('EntranceMarkers').get_children()
		var entrance = entrances.filter(func(x: Marker2D): return x.name == value)
		if not entrance.is_empty():
			global_position = entrance[0].global_position
		elif entrances.size() > 0:
			global_position = entrances[0].global_position
		else:
			global_position = Vector2.ZERO

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
