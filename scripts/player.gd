extends CharacterBody2D

@export var limited_vision := true

@onready var joystick = $"../MobileControls/Joystick"

const SPEED = 150.0
var head_rotation = 0.0

func _ready():
	%Vision.visible = limited_vision
	velocity = Vector2.ZERO

func _process(delta):
	match OS.get_name():
		'Android', 'iOS':
			head_rotation = joystick.joystick_angle
			velocity = joystick.get_joystick_dir() * SPEED
		'Windows', 'macOS':
			head_rotation = get_angle_to(get_global_mouse_position())
			
			velocity = Vector2.ZERO
			if Input.is_action_pressed('move_front'):
				velocity = Vector2.RIGHT.rotated(head_rotation).round()
			elif Input.is_action_pressed('move_back'):
				velocity = (Vector2.LEFT / 1.5).rotated(head_rotation).round()
			if velocity.length() > 1:
				velocity = velocity.normalized()
			velocity *= SPEED
	
	move_and_slide()
	%Vision.rotation = head_rotation
	
	var _rotation = int(head_rotation * 180 / PI) % 360
	if _rotation < 0:
		_rotation += 360
	if _rotation > 315 or _rotation < 45:
		%Animation.animation = 'walk_side'
		%Animation.flip_h = true
	elif _rotation > 45 and _rotation < 135:
		%Animation.animation = 'walk_front'
	elif _rotation < 315 and _rotation > 225:
		%Animation.animation = 'walk_back'
	else:
		%Animation.animation = 'walk_side'
		%Animation.flip_h = false
	%Animation.play()
	
	if velocity.length() == 0:
		%Animation.pause()
		$Animation.frame = 0

func _on_area_2d_body_entered(body: TileMapLayer):
	if body.is_in_group('wall'):
		body.modulate = Color(1, 1, 1, .2)

func _on_area_2d_body_exited(body: TileMapLayer):
	if body.is_in_group('wall'):
		body.modulate = Color(1, 1, 1, 1)
