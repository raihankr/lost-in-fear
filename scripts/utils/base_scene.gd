class_name BaseScene extends Node2D

@onready var black_fade: ColorRect = %BlackFade
@onready var transition: AnimationPlayer = $SceneTransition
@onready var entrance_markers: Node2D = $EntranceMarkers
@onready var follow_camera: Camera2D = $FollowCamera
@onready var player: Player = self.get_node_or_null('Player')

var last_scene: String

func _ready():
	last_scene = SceneManager.last_scene_name
	if SceneManager.player:
		if player:
			player.queue_free()
		player = SceneManager.player
		add_child(player)
	position_player()
	follow_camera.follow_node = player
	
	SceneManager._handle_passed_data(self)
	
	transition.play_backwards('Fade')
	await transition.animation_finished
	black_fade.hide()
	
	player.input_enabled = true

func transition_to(scene: PackedScene) -> void:
	black_fade.show()
	transition.play('Fade')
	await transition.animation_finished
	get_tree().call_deferred('change_scene_to_packed', scene)

func position_player() -> void:
	if last_scene.is_empty():
		last_scene = 'Spawn'
	
	var entrance: Marker2D = entrance_markers.find_child(last_scene)
	if entrance:
		player.global_position = entrance.global_position
