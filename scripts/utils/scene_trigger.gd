extends Area2D

@export_file var connected_scene: String
@export var id: String
@export var key: String
@export var dialogue_locked: String = 'locked_door'
@export var padlock_scene: PackedScene

var dialogue = preload("res://dialogues/globals.dialogue")

func _on_body_entered(body: Node):
	if not id.is_empty() and SaveData.data.door_locked.has(id):
		if SaveData.data.door_locked[id]:
			if padlock_scene:
				var padlock: PadlockSubview = padlock_scene.instantiate()
				get_tree().current_scene.add_child(padlock)
				await padlock.completed
				SaveData.data.door_locked[id] = false
			elif key and Global.has_inventory(key):
				SaveData.data.door_locked[id] = false
				Global.dump_inventory(Global.find_inventory(key))
			else:
				await DialogueManager.show_dialogue_balloon(dialogue, 'door_locked', [owner.player])
				return
	if body is Player:
		SceneManager.change_scene(owner, connected_scene)
