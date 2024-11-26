extends TextureButton

const ITEM_DIR: String = "res://assets/images/item/"

@export var item_id: String = ''
@export var item_name: String = ''

@onready var texture_node: TextureRect = $ItemTexture

func _toggled(toggled_on: bool):
	if not toggled_on:
		Global.selected_inventory = null
	else:
		if not Global.selected_inventory == null:
			get_parent().get_child(Global.selected_inventory).button_pressed = false
		Global.selected_inventory = get_index()

func _get_drag_data(at_position: Vector2):
	#region preview
	if item_name.is_empty():
		return null
	var preview_texture: TextureRect = TextureRect.new()
	
	preview_texture.texture = load(texture_node.texture.resource_path)
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30, 30)
	
	var preview: Control = Control.new()
	preview.z_index = 60
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	#endregion
	
	return [item_id, get_index()]

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if Global.ITEM_COMBINATION.has(item_id):
		if Global.ITEM_COMBINATION[item_id].has(data[0]):
			if data is Array and data.size() == 2:
				if data[0] is String and data[1] is int:
					return true
	return false

func _drop_data(at_position: Vector2, data: Variant):
	var item_id_target: String = data[0]
	var combined_item: Array = Global.ITEM_COMBINATION[item_id][item_id_target]
	Global.dump_inventory(get_index())
	Global.dump_inventory(data[1])
	Global.add_inventory(combined_item)
