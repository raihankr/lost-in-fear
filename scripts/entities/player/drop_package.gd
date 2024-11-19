extends PlayerState

var package_placed: bool = false
var pkg_scene: PackedScene = preload('res://scenes/entities/package.tscn')

func enter(previous_state_path, data := {}):
	if not previous_state_path in [WALK_PACKAGE, IDLE_PACKAGE]:
		finished.emit(IDLE)
		return
	player.animation.play('drop_package')
	player.animation.flip_h = false
	await player.animation.animation_finished
	finished.emit(IDLE, { 'head_rotation': 1.0 / 2 * PI })

func update(delta):
	if (player.animation.frame > 3 and not package_placed):
		var package: StaticBody2D = pkg_scene.instantiate()
		package.global_position = player.global_position
		package.global_position.x -= 8
		player.get_parent().add_child(package)
		package_placed = true
