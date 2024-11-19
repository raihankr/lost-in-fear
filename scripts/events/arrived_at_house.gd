extends Node2D

@onready var animation: AnimationPlayer = $AnimationPlayer

var dialogue: Resource = preload("res://dialogues/living_room.dialogue")
var player: Player = SceneManager.player

func _enter_tree():
	#DialogueManager.show_dialogue_balloon(dialogue, 'arrived_at_house')
	#await DialogueManager.dialogue_ended
	SaveData.data.events.has_entered_house = true
	queue_free()

func close_door():
	animation.play('CloseDoor', -1, 2.0)
	await animation.animation_finished
	player.head_rotation = 1 / 2 * PI
