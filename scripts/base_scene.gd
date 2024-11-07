class_name BaseScene extends Node2D

@onready var transition = $SceneTransition

func _ready():
	transition.play_backwards('Fade')
	await transition.animation_finished

func transition_to(scene: PackedScene):
	transition.play('Fade')
	await transition.animation_finished
	get_tree().change_scene_to_packed(scene)
