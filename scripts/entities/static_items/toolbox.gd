extends StaticItem

func interact():
	if not SaveData.data.events.has_opened_toolbox:
		var padlock: PadlockSubview = preload('res://scenes/subviews/padlock_toolbox.tscn').instantiate()
		get_tree().current_scene.add_child(padlock)
		await padlock.completed
		get_tree().current_scene.player.input_enabled = true
		SaveData.data.events.has_opened_toolbox = true
		
		var room_name: String = get_tree().current_scene.scene_file_path.get_file().get_slice('.', 0)
		
		var item: Array = ['pliers', Vector2(-16, 8)]
		SaveData.data.items[room_name].append(item)
		Global.item_added.emit(item[0], item[1])
		item = ['rope', Vector2(0, 8)]
		SaveData.data.items[room_name].append(item)
		Global.item_added.emit(item[0], item[1])
