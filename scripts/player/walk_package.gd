extends PlayerWalk

func _ready():
	super()
	animations = [
		'walk_front_package',
		'walk_diagonal_front_package',
		'walk_side_package',
		'walk_diagonal_back_package',
		'walk_back_package'
	]
	idle = IDLE_PACKAGE
