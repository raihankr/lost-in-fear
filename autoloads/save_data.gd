extends Node

var save_name: String = '.default'
var data: Dictionary = {}

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data(save_name)
		print('Succesfully saved game states and exitting...')

func _create_save_dir():
	var dir: DirAccess = DirAccess.open('user://')
	if not dir.dir_exists('savedata'):
		dir.make_dir('savedata')

func save_data(path: String = save_name) -> void:
	_create_save_dir()
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(data)
	file.close()

func load_data(path: String) -> Dictionary:
	_create_save_dir()
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var _data  = file.get_var()
	file.close()
	return _data

func load_and_store_data(path: String) -> void:
	data = load_data(path)
