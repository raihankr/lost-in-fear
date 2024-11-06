extends PlayerState

func enter(previous_state_path, data := {}):
	player.animation.play('call')
	await player.animation.animation_finished

func exit():
	player.animation.play_backwards('call')
	
