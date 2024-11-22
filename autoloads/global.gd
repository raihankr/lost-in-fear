extends Node

signal inventory_selected(idx: Variant)
signal inventory_changed(inventory: Array)
signal item_added(item_name: String, position: Vector2)

const ITEM_COMBINATION: Dictionary = {

}
const IMAGE_SUBVIEW = preload("res://scenes/subviews/image_subview.tscn")

var selected_inventory: Variant = null:
	set(value):
		selected_inventory = value
		inventory_selected.emit(value)
var inventory: Array = SaveData.data.inventory

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func add_inventory(item: Array[String]) -> void:
	inventory.append(item)
	inventory_changed.emit(inventory)

func dump_inventory(idx: int) -> void:
	inventory.remove_at(idx)
	inventory_changed.emit(inventory)

func drop_inventory(idx: int) -> void:
	var room_name: String = get_tree().current_scene.scene_file_path.get_file().get_slice('.', 0)
	var item_name: String = inventory[idx][0]
	var player_pos: Vector2 = get_tree().current_scene.player.global_position
	
	SaveData.data.items[room_name].append([item_name, player_pos])
	item_added.emit(item_name, player_pos)
	dump_inventory(idx)

func has_inventory(item_id: String) -> bool:
	return bool(inventory.filter(func(item): item[0] == item_id).front())

func find_inventory(item_id: String) -> int:
	for i in range(inventory.size()):
		if inventory[i][0] == item_id:
			return i
	return -1

func show_image_subview(texture: Texture, texture_data: Dictionary = {}):
	var subview: CanvasLayer = IMAGE_SUBVIEW.instantiate()
	subview.find_child('Texture').texture = texture
	if texture_data.size() > 0:
		for prop in texture_data.keys():
			texture[prop] = texture_data
	get_tree().current_scene.add_child(subview)
	
