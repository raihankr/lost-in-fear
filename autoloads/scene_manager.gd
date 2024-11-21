extends Node

signal scene_changed
signal will_change
signal _ready_to_change

const VIDEO_PLAYER: String = "res://scenes/interfaces/video_player.tscn"

var player: Player
var last_data: Dictionary
var last_scene_name: String = 'Spawn'
var next_scene_name: String

func _transition_and_fetch_player(scene: Node, data: Dictionary = {}):
	last_data = data
	if scene is BaseScene:
		last_scene_name = scene.name
		player = scene.player
		player.input_enabled = false
		scene.black_fade.show()
		scene.transition.play('Fade')
		await scene.transition.animation_finished
		player.get_parent().remove_child(player)
	else:
		last_scene_name = 'Spawn'
		var new_player: Player = preload('res://scenes/entities/player.tscn').instantiate()
		player = new_player

func _handle_passed_data(scene: Node):
	for prop in last_data.keys():
		if last_data[prop] is Dictionary:
			for child_prop in last_data.player.keys():
				scene[prop][child_prop] = last_data[prop][child_prop]

func _switch_scene(from: Node, to: String):
	from.get_tree().call_deferred('change_scene_to_file', to)
	scene_changed.emit()

func change_scene(from: Node, to: String, data: Dictionary = {}) -> void:
	await _transition_and_fetch_player(from, data)
	_switch_scene(from, to)

func init_scene() -> BaseScene:
	var scene: BaseScene = preload('res://scenes/utils/base_scene.tscn').instantiate()
	scene.name = 'Spawn'
	return scene
