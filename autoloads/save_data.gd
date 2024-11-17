extends Node

signal _data_stored
signal save

const NEW_GAME_TEMPLATE: Dictionary = {
	'scene_path': "res://scenes/world/outdoor.tscn",
	'player': {
		'world_position': 'Spawn',
		'state': 'Idle',
		'visible': true,
		'walk_sound': 'wood'
	},
	'inventory': {
		'selected': null,
		'items': []
	},
	'items': {
		
	},
	'has_entered_house': false,
	'door_locked': {
		'bedroom_1': true
	}
}

var save_name: String = '.default'
var data: Dictionary = {}
var autosave_timer: Timer = Timer.new()

func _ready():
	process_priority = 10
	autosave_timer.autostart = true
	autosave_timer.wait_time = 180
	autosave_timer.timeout.connect(save_data) # Autosave every 180 seconds
	SceneManager.scene_changed.connect(save_data) # Autosave every scene change
	new_game()

func _create_save_dir():
	var dir: DirAccess = DirAccess.open('user://')
	if not dir.dir_exists('savedata'):
		dir.make_dir('savedata')

func new_game():
	data = NEW_GAME_TEMPLATE.duplicate(true)
	
func save_data(name: String = save_name) -> void:
	save.emit()
	for saving_process in save.get_connections():
		await _data_stored
	_create_save_dir()
	var file: FileAccess = FileAccess.open('user://savedata/%s.dat' % name, FileAccess.WRITE)
	file.store_var(data)
	file.close()
	print('Data succesfully saved in storage')

func load_data(name: String = save_name) -> Dictionary:
	_create_save_dir()
	var file: FileAccess = FileAccess.open('user://savedata/%s.dat' % name, FileAccess.READ)
	var _data  = file.get_var()
	file.close()
	return _data

func load_and_store_data(name: String = save_name) -> void:
	data = load_data(name)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()
