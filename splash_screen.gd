extends Control

func _ready():
	$AnimationPlayer.play("SplashScreen")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
