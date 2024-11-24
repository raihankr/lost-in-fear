extends StaticItem

var _dialogue: Resource = preload("res://dialogues/living_room.dialogue")

func interact():
	Global.show_image_subview(preload('res://assets/images/subviews/newspaper.png'))
	DialogueManager.show_dialogue_balloon(_dialogue, 'found_newspaper')
