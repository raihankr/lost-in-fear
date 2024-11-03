extends PlayerState

var package_placed := false
var pkg_scene = preload('res://scenes/package.tscn')

func enter(previous_state_path, data := {}):
	if not previous_state_path in [WALK_PACKAGE, IDLE_PACKAGE]:
		finished.emit(IDLE)
		return
	player.animation.play('drop_package')
	await player.animation.animation_finished
	finished.emit(IDLE, { 'head_rotation': 1.0 / 2 * PI })

func update(delta):
	if (player.animation.frame > 3 and not package_placed):
		var package = pkg_scene.instantiate()
		package.global_position = player.global_position
		package.global_position.x -= 8
		player.get_parent().add_child(package)
		package_placed = true
