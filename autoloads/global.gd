extends Node

@onready var player = $/root/Main/Player

var enable_input: bool = true:
	set(value):
		if player:
			player.enable_input = value
	get:
		if player:
			return player.enable_input
		else: return false

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
