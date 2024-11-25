class_name MainMenu
extends Control

@onready var Btn_NewGame = $MarginContainer/HBoxContainer/VBoxContainer/Btn_NewGame as Button
@onready var Btn_LoadGame = $MarginContainer/HBoxContainer/VBoxContainer/Btn_LoadGame as Button
@onready var Btn_Options = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Options as Button
@onready var Options_Menu  = $Options_Menu as OptionsmMenu
@onready var Btn_Quit = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Quit as Button
@onready var Margin_Container = $MarginContainer as MarginContainer

func _ready():
	var save_dir: DirAccess = DirAccess.open('user://')
	if not save_dir.file_exists('savedata/%s.dat' % SaveData.save_name):
		Btn_LoadGame.disabled = true
	InGameUI.enable(false, false)
	handle_connecting_signals()
	
func on_option_pressed() -> void:
	Margin_Container.visible = false
	Options_Menu.set_process(true)
	Options_Menu.visible = true

func run_game(scene: String, save_data: Dictionary):
	var data: Dictionary = {
		'player': {
			'world_position': save_data.player.world_position,
			'state': save_data.player.state,
			'visible': save_data.player.visible
		}
	}
	SceneManager.change_scene(self, scene, data)
	
func on_start_pressed() -> void:
	SaveData.new_game()
	run_game(SaveData.data.scene_path, SaveData.data)

func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_exit_options_menu() -> void:
	Margin_Container.visible = true
	Options_Menu.visible = false

func handle_connecting_signals() -> void:
		Btn_NewGame.button_down.connect(on_start_pressed)
		Btn_Options.button_down.connect(on_option_pressed)
		Btn_Quit.button_down.connect(on_exit_pressed)
		Options_Menu.exit_options_menu.connect(on_exit_options_menu)
		Btn_LoadGame.button_down.connect(on_load_pressed)
		
func on_load_pressed() -> void:
	SaveData.load_and_store_data()
	run_game(SaveData.data.scene_path, SaveData.data)
		
func btn_click():
	$MenuSelectionClick.play()
	
