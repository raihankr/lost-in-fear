extends TextureButton

func _can_drop_data(at_position: Vector2, data: Variant):
	return data is Array and data.size() >= 2

func _drop_data(at_position: Vector2, data: Variant):
	Global.drop_inventory(data[1])

func _pressed():
	if Global.selected_inventory != null:
		if Global.inventory.size() > Global.selected_inventory:
			Global.drop_inventory(Global.selected_inventory)

func _on_button_down():
	modulate = Color(0.7, 0.7, 0.7, 1)

func _on_button_up():
	modulate = Color.WHITE
