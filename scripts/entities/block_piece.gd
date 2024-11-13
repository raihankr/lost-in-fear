extends CharacterBody2D

enum Axis {X_AXIS, Y_AXIS}

@export var move_axis: Axis = Axis.X_AXIS

var dragging: bool = false

func _process(delta: float):
	if dragging:
		var mouse_position: Vector2 = get_global_mouse_position()
		var distance: float
		var direction: Vector2 = global_position.direction_to(mouse_position)
		var speed: float = distance / delta
		velocity = Vector2.ZERO
		match move_axis:
			Axis.X_AXIS:
				distance = mouse_position.x - global_position.x
				speed = distance / delta
				velocity.x = speed
			Axis.Y_AXIS:
				distance = mouse_position.y - global_position.y
				speed = distance / delta
				velocity.y = speed
		move_and_slide()

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and dragging and not event.is_pressed():
		dragging = false

func _input_event(viewport, event: InputEvent, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.is_pressed()
