extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogue_1 = preload("res://dialogues/scene_1.dialogue")
	await DialogueManager.show_dialogue_balloon(dialogue_1, 'start')
