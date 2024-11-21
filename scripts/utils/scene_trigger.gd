extends Area2D

@export_file var connected_scene: String
@export var id: String

var dialogue = preload("res://dialogues/globals.dialogue")

func _on_body_entered(body: Node):
	if not id.is_empty() and SaveData.data.door_locked.has(id):
		if SaveData.data.door_locked[id]:
			await DialogueManager.show_dialogue_balloon(dialogue, 'door_locked', [owner.player])
			return
	if body is Player:
		SceneManager.change_scene(owner, connected_scene)
