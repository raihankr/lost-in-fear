extends Control

func _ready():
	InGameUI.enable(false, false)
	$AnimationPlayer.play("SplashScreen")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://main.tscn")
