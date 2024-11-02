extends Node2D

func _ready():
	var dialogue = preload("res://dialogues/scene_1.dialogue")
	set_process(false)
	await Global.wait(3)
	set_process(true)

func _process(delta):
	move_car(delta)
	
func move_car(delta):
	if (%CarPosition.progress_ratio < 1):
		%Car.play('moving')
		%CarPosition.progress += 100 * delta
	else:
		%Car.frame = 0
		%Car.pause()
