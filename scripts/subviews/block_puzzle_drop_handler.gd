extends Control

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Array and data.size() == 2

func _drop_data(at_position: Vector2, data: Variant):
	if data[0] == 'block_puzzle':
		Global.dump_inventory(data[1])
		SaveData.data.events.has_put_the_missing_block_puzzle = true
		var main_block = get_parent().find_child('MainBlock', true)
		main_block.set_process(true)
		main_block.show()
