extends Subview

@onready var target: Area2D = %Target
@onready var main_block: CharacterBody2D = %MainBlock

var dialogue: Resource = preload('res://dialogues/play_room.dialogue')

func _ready():
	if SaveData.data.events.has_solved_block_puzzle:
		DialogueManager.show_dialogue_balloon(dialogue, 'puzzle_had_completed')
		close()
		return
	
	get_tree().current_scene.player.input_enabled = false
	
	if (Global.has_inventory('block_puzzle')):
		Global.dump_inventory(Global.find_inventory('block_puzzle'))
		SaveData.data.events.has_put_the_missing_block_puzzle = true
	
	if SaveData.data.events.has_put_the_missing_block_puzzle:
		main_block.show()
	else:
		main_block.hide()
		DialogueManager.show_dialogue_balloon(dialogue, 'uncomplete_puzzle')

func _on_target_body_entered(body: Node):
	if body.is_in_group('main_block'):
		if not SaveData.data.events.has_solved_block_puzzle:
			Global.add_inventory(['storage_hint', "res://assets/images/item/written-note.png", 'Catatan'])
			SaveData.data.events.has_solved_block_puzzle = true
			DialogueManager.show_dialogue_balloon(dialogue, 'puzzle_completed')
			await DialogueManager.dialogue_ended
			close()

func close():
	get_tree().current_scene.player.input_enabled = true
	queue_free()
