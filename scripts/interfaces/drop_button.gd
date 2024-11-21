extends TextureButton

func _can_drop_data(at_position: Vector2, data: Variant):
	modulate = Color(0, 0, 0, .5)
	return data is Array and data.size() >= 2

func _drop_data(at_position: Vector2, data: Variant):
	Global.drop_inventory(data[1])

func _pressed():
	if Global.selected_inventory != null:
		Global.drop_inventory(Global.selected_inventory)
	modulate = Color(0, 0, 0, .5)
