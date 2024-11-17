extends MarginContainer

@onready var continue_btn: Button = %ContinueButton
@onready var new_game_btn: Button = %NewGameButton
@onready var scene_path_display: RichTextLabel = %ScenePath
@onready var pick_scene_btn: Button = %PickSceneButton
@onready var load_new_game_btn: Button = %LoadNewGameButton
@onready var load_last_save_btn: Button = %LoadLastSaveButton
@onready var save_data_edit: TextEdit = %SaveData
@onready var file_dialog: FileDialog = %FileDialog

var scene_path: String:
	set(value):
		scene_path = value
		scene_path_display.text = value
var save_name = '.default'

func _ready():
	var save_dir: DirAccess = DirAccess.open('user://')
	if not save_dir.file_exists('savedata/%s.dat' % save_name):
		continue_btn.disabled = true
		load_last_save_btn.disabled = true
	scene_path = SaveData.NEW_GAME_TEMPLATE.scene_path
	save_data_edit.text = JSON.stringify(SaveData.NEW_GAME_TEMPLATE, '	')

func run_game(scene: String, save_data: Dictionary):
	var data: Dictionary = {
		'player': {
			'world_position': save_data.player.world_position,
			'state': save_data.player.state,
			'visible': save_data.player.visible
		}
	}
	SceneManager.change_scene(self, scene, data)

func _on_continue_button_pressed():
	SaveData.load_and_store_data('.default')
	run_game(SaveData.data.scene_path, SaveData.data)

func _on_new_game_button_pressed():
	SaveData.data = JSON.parse_string(save_data_edit.text)
	run_game(scene_path, SaveData.data)

func _on_pick_scene_button_pressed():
	file_dialog.show()

func _on_file_dialog_file_selected(path):
	scene_path = path

func _on_load_last_save_button_pressed():
	var save_data: Dictionary = SaveData.load_data('.default')
	save_data_edit.text = JSON.stringify(save_data, '	')
	scene_path = save_data.scene_path

func _on_load_new_game_button_pressed():
	save_data_edit.text = JSON.stringify(SaveData.NEW_GAME_TEMPLATE, '	')
