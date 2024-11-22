extends Item

var dialogue: Resource = preload('res://dialogues/living_room.dialogue')

func pick_up(save_to_inventory: bool = true):
	get_tree().current_scene.just_got_flashlight.emit()
	var player: Player = get_tree().current_scene.player
	player.state_machine.enter('IdleFlashlight')
	DialogueManager.show_dialogue_balloon(dialogue, 'got_flashlight')
	_remove_from_world()
	InGameUI.show_toast(item_name)
	queue_free()
