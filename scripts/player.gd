extends CharacterBody2D

@export var speed := 90
@export var limited_vision := true
@export var enable_input := true

@onready var joystick = $"../MobileControls/Joystick"\
	if ['Android', 'iOS'].has(OS.get_name()) else null

enum States {IDLE, WALK, WALK_PACKAGE, DROP_PACKAGE, CALL}

var state: States = States.IDLE
var head_rotation := 0.0

func _ready():
	%Vision.visible = limited_vision
	velocity = Vector2.ZERO

func _process(delta):
	var dir := 0
	if enable_input:
		match OS.get_name():
			'Android', 'iOS':
				head_rotation = joystick.joystick_angle
				dir = joystick.get_joystick_dir().length()
			'Windows', 'macOS':
				head_rotation = get_angle_to(get_global_mouse_position())
				if global_position.distance_to(get_global_mouse_position()) < 16: dir = 0
				elif Input.is_action_pressed('move_front'): dir = 1

	var _rotation = int(head_rotation * 180 / PI) % 360
	if _rotation < 0:
		_rotation += 360
	%Animation.play()

	if _rotation < 22.5 or _rotation > 337.5:
		%Animation.animation = 'walk_side'
	elif _rotation < 67.5:
		%Animation.animation = 'walk_diagonal_front'
	elif _rotation < 112.5:
		%Animation.animation = 'walk_front'
	elif _rotation < 157.5:
		%Animation.animation = 'walk_diagonal_front'
	elif _rotation < 202.5:
		%Animation.animation = 'walk_side'
	elif _rotation < 247.5:
		%Animation.animation = 'walk_diagonal_back'
	elif _rotation < 292.5:
		%Animation.animation = 'walk_back'
	elif _rotation < 337.5:
		%Animation.animation = 'walk_diagonal_back'	
	
	match %Animation.animation:
		'walk_side': velocity = Vector2.LEFT
		'walk_front': velocity = Vector2.DOWN 
		'walk_back': velocity = Vector2.UP
		'walk_diagonal_front': velocity = Vector2(-1, 1).normalized()
		'walk_diagonal_back': velocity = Vector2(-1, -1).normalized()
		_: velocity = Vector2.ZERO

	%Animation.flip_h = false
	if _rotation > 270 or _rotation < 90:
		%Animation.flip_h = true
		velocity.x *= -1	
	
	velocity *= speed * dir
	
	%Vision.rotation = head_rotation
	
	if velocity.length() == 0:
		%Animation.pause()
		%Animation.frame = 0
		
	move_and_slide()

func _on_area_2d_body_entered(body: TileMapLayer):
	if body.is_in_group('wall'):
		body.modulate = Color(1, 1, 1, .2)

func _on_area_2d_body_exited(body: TileMapLayer):
		body.modulate = Color(1, 1, 1, 1)
