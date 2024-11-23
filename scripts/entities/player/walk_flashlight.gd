extends PlayerWalk

func _ready():
	super()
	animations = [
		'walk_front_flashlight',
		'walk_diagonal_front_flashlight',
		'walk_side_flashlight',
		'walk_diagonal_back_flashlight',
		'walk_back_flashlight'
	]
	idle = IDLE_FLASHLIGHT
	vision_style = player.VisionStyle.CONE
