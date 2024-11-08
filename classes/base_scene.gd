class_name BaseScene extends Node2D

@onready var black_fade: ColorRect = %BlackFade
@onready var transition: AnimationPlayer = $SceneTransition

func _ready():
	transition.play_backwards('Fade')
	await transition.animation_finished
	black_fade.hide()

func transition_to(scene: PackedScene) -> void:
	black_fade.show()
	transition.play('Fade')
	await transition.animation_finished
	get_tree().change_scene_to_packed(scene)
