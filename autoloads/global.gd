extends Node

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
