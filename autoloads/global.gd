extends Node

@onready var player = $/root/Main/Player

var enable_input: bool = true:
	set(value):
		player.enable_input = value
	get:
		return player.enable_input

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
