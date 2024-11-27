class_name PlayerWalk extends PlayerState

var animations: Array[String] = [
	'walk_front',
	'walk_diagonal_front',
	'walk_side',
	'walk_diagonal_back',
	'walk_back'
]
var idle: String = IDLE
var vision_style: int = player.VisionStyle.NONE
var target_position: Variant = null
var initial_speed: int

func enter(previous_state_path, data := {}):
	initial_speed = player.move_speed
	player.vision_style = vision_style
	player.animation.play()
	if data.has('target_position') and data.target_position is Vector2:
		target_position = data.target_position
		player.input_enabled = false
		player.head_rotation = player.global_position.angle_to_point(target_position)
	if data.has('move_speed') and data.move_speed is int:
		player.move_speed = data.move_speed

func update(delta):
	player.animation.animation = animations[player.rotation_state]
	if not player.footstep_sound.playing:
		player._play_footstep_sound()
	if target_position == null:
		
		match player.rotation_state:
			player.Rotation.SIDE: player.velocity = Vector2.LEFT
			player.Rotation.FRONT: player.velocity = Vector2.DOWN 
			player.Rotation.BACK: player.velocity = Vector2.UP
			player.Rotation.DIAGONAL_FRONT: player.velocity = Vector2(-1, 1).normalized()
			player.Rotation.DIAGONAL_BACK: player.velocity = Vector2(-1, -1).normalized()
		
		match player.horizontal_heading:
			player.Direction.LEFT:
				player.animation.flip_h = false
			player.Direction.RIGHT:
				player.animation.flip_h = true
				player.velocity.x *= -1
		
		player.velocity *= player.move_speed * player.speed
	
		player.move_and_slide()
	else:
		var new_pos = player.global_position.move_toward(target_position, player.move_speed * delta)
		player.global_position = new_pos
		if target_position == new_pos:
			player.move_speed = initial_speed
			target_position = null
			player.input_enabled = false

func update_end():
	if target_position == null and not player.speed:
		finished.emit(idle)
