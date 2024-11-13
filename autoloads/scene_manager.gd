extends Node

const VIDEO_PLAYER: String = "res://scenes/interfaces/video_player.tscn"

var player: Player
var last_data: Dictionary
var last_scene_name: String = 'Spawn'

func _transition_and_fetch_player(scene: BaseScene):
	last_scene_name = scene.name
	player = scene.player
	player.input_enabled = false
	scene.black_fade.show()
	scene.transition.play('Fade')
	await scene.transition.animation_finished
	player.get_parent().remove_child(player)

func _handle_passed_data(scene: Node):
	for prop in last_data.keys():
		if last_data[prop] is Dictionary:
			for child_prop in last_data.player.keys():
				scene[prop][child_prop] = last_data[prop][child_prop]

func _switch_scene(from: BaseScene, to: String):
	from.get_tree().call_deferred('change_scene_to_file', to)

func change_scene(from: BaseScene, to: String, data: Dictionary = {}) -> void:
	last_data = data
	await _transition_and_fetch_player(from)
	_switch_scene(from, to)

func show_video_scene(from: BaseScene, video_path: String, next_scene: String) -> void:
	_transition_and_fetch_player(from)
	_switch_scene(from, VIDEO_PLAYER)
