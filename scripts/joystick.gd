extends TouchScreenButton

@export var remember_rotation = true

var max_distance := 32
var center := Vector2(32, 32)
var joystick_angle := 0.0
var touched := false
var init_pos: Vector2

func _ready():
	init_pos = global_position
	print(init_pos)

func _input(event: InputEvent):
	if event is InputEventScreenTouch:
		print(event.pressed)
		if event.pressed and touched:
			print('yes')
			_update_joystick(event.position)
		else:
			%Tip.position = center
			global_position = init_pos
			if not remember_rotation:
				joystick_angle = 0
	elif event is InputEventScreenDrag and touched:
		_update_joystick(event.position)
	
func _update_joystick(position: Vector2):
	%Tip.global_position = position
	%Tip.position = center + (%Tip.position - center).limit_length(max_distance)
	joystick_angle = Vector2.ZERO.angle_to_point(get_joystick_dir())
	

func get_joystick_dir() -> Vector2:
	var dir = %Tip.position - center
	return dir.normalized()

func _on_pressed():
	touched = true

func _on_released():
	touched = false
