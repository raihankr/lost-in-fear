class_name MainMenu
extends Control

@onready var Btn_Start = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Start as Button
@onready var Btn_Options = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Options as Button
@onready var Options_Menu  = $Options_Menu as OptionsmMenu
@onready var Btn_Credits = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Credits as Button
@onready var Btn_Quit = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Quit as Button
@onready var Load_Game = preload("res://scenes/world/outdoor.tscn") as PackedScene
@onready var Margin_Container = $MarginContainer as MarginContainer

func _ready():
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
	SaveData.load_and_store_data('.default')
	run_game(SaveData.data.scene_path, SaveData.data)

func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_exit_options_menu() -> void:
	Margin_Container.visible = true
	Options_Menu.visible = false

func handle_connecting_signals() -> void:
		Btn_Start.button_down.connect(on_start_pressed)
		Btn_Options.button_down.connect(on_option_pressed)
		Btn_Quit.button_down.connect(on_exit_pressed)
		Options_Menu.exit_options_menu.connect(on_exit_options_menu)
		
		
		
	
	
	



	
	
