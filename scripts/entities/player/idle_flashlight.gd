extends "res://scripts/entities/player/idle.gd"

func _ready():
	super()
	animation = 'idle_flashlight'
	vision_style = player.VisionStyle.CONE

func update_end():
	if player.speed:
		finished.emit(WALK_fLASHLIGHT)
