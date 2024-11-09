extends Node

@onready var player: Player = $/root.get_node_or_null('Main/Player')

var input_enabled: bool = true:
	set(value):
		if player:
			player.input_enabled = value
	get:
		if player:
			return player.input_enabled
		else: return false

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
