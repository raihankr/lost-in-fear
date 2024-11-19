extends Item

func pick_up(save_to_inventory: bool = true):
	var player: Player = get_tree().current_scene.player
	player.vision_style = player.VisionStyle.CONE
	queue_free()
