class_name BaseScene extends Node2D

@onready var black_fade: ColorRect = %BlackFade
@onready var transition: AnimationPlayer = $SceneTransition
@onready var entrance_markers: Node2D = $EntranceMarkers
@onready var follow_camera: Camera2D = $FollowCamera
@onready var player: Player = self.get_node_or_null('Player')

var last_scene: String

func _ready():
	_setup()
	_fade_in()
	SaveData.save.connect(store_save_data)

func _setup():
	last_scene = SceneManager.last_scene_name
	if SceneManager.player:
		if player:
			player.queue_free()
		player = SceneManager.player
		player.world_position = [last_scene, self]
		add_child(player)
	follow_camera.follow_node = player
	
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
	print('Savedata stored in memory')
	SaveData._data_stored.emit()

func transition_to(scene: PackedScene) -> void:
	black_fade.show()
	transition.play('Fade')
	await transition.animation_finished
	get_tree().call_deferred('change_scene_to_packed', scene)
