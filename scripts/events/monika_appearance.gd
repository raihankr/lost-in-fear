extends Node2D

@onready var player = get_tree().current_scene.player

var dialogue: Resource = preload("res://dialogues/living_room.dialogue")

func _on_trigger_body_entered(body):
	if body is Player:
		DialogueManager.show_dialogue_balloon(dialogue, 'see_monika')
		await DialogueManager.dialogue_ended
		$AnimationPlayer.play("WalkAway")
