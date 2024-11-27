extends Control

func _can_drop_data(at_position, data):
	if data is Array and data.size() == 2:
		print('yes')
		if SaveData.data.events.has_opened_window_seal and data[0] == 'rope':
			return true
		elif not SaveData.data.events.has_opened_window_seal and data[0] == 'pliers':
			return true
	return false

func _drop_data(at_position, data):
	if not SaveData.data.events.has_opened_window_seal and data[0] == 'pliers':
		get_parent().texture_node.texture = preload("res://assets/images/subviews/wall_break_closeup_after.png")
		SaveData.data.events.has_opened_window_seal = true
	elif SaveData.data.events.has_opened_window_seal and data[0] == 'rope':
		var epilog = preload('res://scenes/subviews/epilog.tscn').instantiate()
		get_tree().current_scene.add_child(epilog)
		await epilog.find_child('AnimationPlayer').animation_finished
		get_tree().change_scene_to_file("res://main.tscn")
