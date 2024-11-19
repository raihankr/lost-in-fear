extends TextureButton

const ITEM_DIR: String = "res://assets/images/item/"

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
	return [item_name, get_index()]

func _can_drop_data(at_position: Vector2, data: Variant):
	return
