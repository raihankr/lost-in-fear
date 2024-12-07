extends PlayerState

var animation: String = 'idle'
var vision_style: int = player.VisionStyle.NONE

func enter(previos_state_path, data := {}):
	player.animation.animation = animation
	player.vision_style = vision_style
	if data.has('head_rotation') and data.head_rotation != null:
		player.head_rotation = data.head_rotation
	update(0)
	player.animation.pause()

func update(delta):
	player.animation.frame = player.rotation_state
	match player.horizontal_heading:
		player.Direction.LEFT:
			player.animation.flip_h = false
		player.Direction.RIGHT:
			player.animation.flip_h = true

func update_end():
	if player.speed:
		finished.emit(WALK)
