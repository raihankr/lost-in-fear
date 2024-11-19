extends TextureRect

func _can_drop_data(at_position: Vector2, data: Variant):
	return data is Array and data.size() >= 2

func _drop_data(at_position: Vector2, data: Variant):
	Global.drop_inventory(data[1])
