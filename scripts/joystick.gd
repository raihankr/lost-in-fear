extends TouchScreenButton

@export var remember_rotation = true

var max_distance := 32
var center := texture_normal.get_size() / 2
var global_center := Vector2(center.x * scale.x, center.y * scale.y)
var joystick_angle := 0.0
var touched := false
var touch_radius = texture_normal.get_width() * scale.x * 3
var init_pos: Vector2

func _ready():
	init_pos = global_position

func _input(event: InputEvent):
	if event is InputEventScreenTouch:
		if event.pressed and _is_inside_joystick_area(event.position):
			touched = true
			global_position = event.position - global_center
			_update_joystick(event.position)
		else:
			global_position = init_pos
			touched = false
			%Tip.position = center
			if not remember_rotation:
				joystick_angle = 0
	elif event is InputEventScreenDrag and touched:
		_update_joystick(event.position)
	
func _update_joystick(pos: Vector2):
	%Tip.global_position = pos
	%Tip.position = center + (%Tip.position - center).limit_length(max_distance)
	joystick_angle = Vector2.ZERO.angle_to_point(get_joystick_dir())

func _is_inside_joystick_area(point: Vector2) -> bool:
	print(point.distance_to(global_position + global_center))
	return point.distance_to(global_position + global_center) < touch_radius

func get_joystick_dir() -> Vector2:
	var dir = %Tip.position - center
	return dir.normalized()
