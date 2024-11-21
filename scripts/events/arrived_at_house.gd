extends Node2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var player: Player = get_tree().current_scene.player

var dialogue: Resource = preload("res://dialogues/living_room.dialogue")

func _ready():
	await get_tree().current_scene._fade_in()
	DialogueManager.show_dialogue_balloon(dialogue, 'arrived_at_house', [self])
	await DialogueManager.dialogue_ended
	SaveData.data.events.has_entered_house = true
	queue_free()

func close_door():
	animation.play('CloseDoor', -1, 3.0)
	await animation.animation_finished
