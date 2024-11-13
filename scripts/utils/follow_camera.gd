extends Camera2D

@export var follow_node: Node2D:
	set(value):
		follow_node = value
		enabled = true

func _process(delta: float):
	if not follow_node:
		enabled = false
	global_position = follow_node.global_position
