class_name BaseScene extends Node2D

const ITEMS_DIR: String = "res://scenes/entities/items/"

@onready var black_fade: ColorRect = %BlackFade
@onready var transition: AnimationPlayer = $SceneTransition
@onready var entrance_markers: Node2D = $EntranceMarkers
@onready var follow_camera: Camera2D = $FollowCamera
@onready var items_root: Node = $Items
@onready var player: Player = self.get_node_or_null('Player')

var last_scene: String
var items_save: Array

func _ready():
	_setup()
	await _fade_in()

func _setup():
	SaveData.save.connect(store_save_data)
	Global.item_added.connect(add_item)
	if SaveData.data.items.has(name.to_snake_case()):
		items_save = SaveData.data.items[name.to_snake_case()]
	InGameUI.enable(true)
	last_scene = SceneManager.last_scene_name
	if SceneManager.player:
		if player:
			player.queue_free()
		player = SceneManager.player
		player.world_position = [last_scene, self]
		add_child(player)
	follow_camera.follow_node = player
	
	for item in items_save:
		var item_node: Item = load(ITEMS_DIR + item[0] + '.tscn').instantiate()
		item_node.position = item[1]
		items_root.add_child(item_node)
	
	SceneManager._handle_passed_data(self)

func _fade_in():
	transition.play_backwards('Fade')
	await transition.animation_finished
	black_fade.hide()
	
	player.input_enabled = true

func store_save_data():
	SaveData.data.scene_path = self.scene_file_path
	SaveData.data.player.world_position = player.position
	SaveData.data.player.state = player.state_machine.state.name
	SaveData._data_stored.emit()

func transition_to(scene: PackedScene) -> void:
	black_fade.show()
	transition.play('Fade')
	await transition.animation_finished
	get_tree().call_deferred('change_scene_to_packed', scene)

func add_item(item_name: String, position: Vector2):
	var new_item: Item = load(ITEMS_DIR + item_name + '.tscn').instantiate()
	new_item.global_position = position 
	items_root.add_child(new_item)
