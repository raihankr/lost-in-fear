extends "idle.gd"

func _ready():
	super()
	animation = 'idle_package'

func update_end():
	if player.speed:
		finished.emit(WALK_PACKAGE)
