extends Node

signal inventory_selected(idx: Variant)
signal inventory_changed(inventory: Array)
signal item_added(item_name: String, position: Vector2)
signal subview_closed

const ITEMS = {
	'brush_grape_juice': ['brush_grape_juice', "res://assets/images/item/brush_grape_juice.png", 'Kuas & Jus Anggur'],
	'revealed_office_hint': ['revealed_office_hint', "res://assets/images/item/written-note.png", 'Catatan']
}
const ITEM_COMBINATION: Dictionary = {
	'grape_juice': {
		'brush': ITEMS.brush_grape_juice
	},
	'brush': {
		'grape_juice': ITEMS.brush_grape_juice
	},
	'brush_grape_juice': {
		'invisible_office_hint': ITEMS.revealed_office_hint
	},
	'invisible_office_hint': {
		'brush_grape_juice': ITEMS.revealed_office_hint
	}
}
const IMAGE_SUBVIEW: PackedScene = preload("res://scenes/subviews/image_subview.tscn")
const VIDEO_PLAYER: PackedScene = preload('res://scenes/interfaces/video_player.tscn')
const ITEM_CLOSEUPS: String = "res://assets/images/item_closeups/"

var subview_visible: bool = false:
	set(value):
		if value:
			subview_visible = value
		else:
			await Global.wait(1)
			subview_visible = value
var selected_inventory: Variant = null:
	set(value):
		selected_inventory = value
		if value != null and inventory.size() > value:
			InGameUI.show_toast(inventory[value][2])
			
			var closeups_dir: DirAccess = DirAccess.open(ITEM_CLOSEUPS)
			var closeup_file: String = inventory[value][0] + '.png'
			if closeups_dir.file_exists(closeup_file):
				show_image_subview(load(ITEM_CLOSEUPS + closeup_file))
				return
		inventory_selected.emit(selected_inventory)
var inventory: Array = []

func _ready():
	SaveData.loaded.connect(load_inventory)
	SaveData.save.connect(save_inventory)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func add_inventory(item: Array) -> void:
	inventory.append(item)
	InGameUI.notify(item[2], load(item[1]))
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
	return inventory.filter(func(item): return item[0] == item_id).size()

func find_inventory(item_id: String) -> int:
	for i in range(inventory.size()):
		if inventory[i][0] == item_id:
			return i
	return -1

func save_inventory() -> void:
	SaveData.data.inventory = inventory
	SaveData._data_stored.emit()

func load_inventory() -> void:
	inventory = SaveData.data.inventory
	inventory_changed.emit(inventory)

func show_image_subview(texture: Texture, touch_anywhere: bool = false, subview_data: Dictionary = {}, texture_data: Dictionary = {}):
	var subview: CanvasLayer = IMAGE_SUBVIEW.instantiate()
	subview.touch_anywhere_to_close = touch_anywhere
	subview.find_child('Texture').texture = texture
	if texture_data.size() > 0:
		for prop in texture_data.keys():
			texture[prop] = texture_data[prop]
	get_tree().current_scene.add_child(subview)

func show_video(video: VideoStream, root: CanvasLayer, free_on_finished: bool = true) -> VideoStreamPlayer:
	var video_player: VideoStreamPlayer = VIDEO_PLAYER.instantiate()
	video_player.free_on_finished = free_on_finished
	video_player.stream = video
	root.add_child(video_player)
	video_player.play()
	await video_player.finished
	return video_player
