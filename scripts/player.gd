extends CharacterBody2D

@export var limited_vision := true

const SPEED = 150.0

func _ready():
	%Vision.visible = limited_vision

func _process(delta):
	%MouseRotation.look_at(get_global_mouse_position())
	%Vision.global_rotation = %MouseRotation.global_rotation
	
	var _rotation = int(%MouseRotation.rotation_degrees) % 360
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
	
	velocity = Vector2.ZERO
	if Input.is_action_pressed('move_front'):
		velocity = Vector2.RIGHT.rotated(%MouseRotation.rotation)
	elif Input.is_action_pressed('move_back'):
		velocity = (Vector2.LEFT / 1.5).rotated(%MouseRotation.rotation)
	else:
		%Animation.animation = 'idle'
	velocity *= SPEED

	move_and_slide()

func _on_area_2d_body_entered(body: TileMapLayer):
	if body.is_in_group('wall'):
		body.modulate = Color(1, 1, 1, .2)

func _on_area_2d_body_exited(body: TileMapLayer):
	if body.is_in_group('wall'):
		body.modulate = Color(1, 1, 1, 1)
