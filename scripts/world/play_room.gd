extends BaseScene

var dialogue: Resource = preload('res://dialogues/play_room.dialogue')

func _ready():
	super()
	if not SaveData.data.events.has_entered_play_room:
		DialogueManager.show_dialogue_balloon(dialogue, 'first_visit')
		SaveData.data.events.has_entered_play_room = true
