extends Area2D

@export_file var connected_scene: String

func _on_body_entered(body: Node):
	if body is Player:
		SceneManager.change_scene(owner, connected_scene)
