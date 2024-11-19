extends Item

func pick_up(save_to_inventory: bool = true):
	var player: Player = SceneManager.player
	player.vision_style = player.VisionStyle.CONE
	queue_free()
