extends Node

@onready var player: Player = $/root.get_node_or_null('Main/Player')

var enable_input: bool = true:
	set(value):
		if player:
			player.enable_input = value
	get:
		if player:
			return player.enable_input
		else: return false

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
