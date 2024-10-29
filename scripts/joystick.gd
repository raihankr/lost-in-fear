extends TouchScreenButton

@export var remember_rotation = true

var max_distance = shape.radius
var center = texture_normal.get_size() / 2
var joystick_angle := 0.0

func _ready():
	pass

func _input(event: InputEvent):
	if event is InputEventScreenTouch:
		if event.pressed:
			_update_joystick(event.position)
		else:
			%Tip.position = center
			if not remember_rotation:
				joystick_angle = 0
	elif event is InputEventScreenDrag:
		_update_joystick(event.position)

func _process(delta):
	#print(get_joystick_angle())
	pass
	
func _update_joystick(position: Vector2):
	%Tip.global_position = position
	%Tip.position = center + (%Tip.position - center).limit_length(max_distance)
	joystick_angle = Vector2.ZERO.angle_to_point(get_joystick_dir())

func get_joystick_dir() -> Vector2:
	var dir = %Tip.position - center
	return dir.normalized()
