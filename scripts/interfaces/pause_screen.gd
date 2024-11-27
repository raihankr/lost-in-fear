extends CanvasLayer

@onready var BtnResume = $PauseMenuContainer/PanelContainer/MarginContainer/Rows/BtnResume as Button
@onready var BtnOptions = $PauseMenuContainer/PanelContainer/MarginContainer/Rows/BtnOptions as Button
@onready var BtnExit = $PauseMenuContainer/PanelContainer/MarginContainer/Rows/BtnExit as Button

@onready var options_menu: Control = $Options_Menu

func _ready():
	options_menu.z_index = 10
	
func toggle_pause_menu():
	if visible:
		visible = false 
		get_tree().paused = false
	else:
		visible = true
		get_tree().paused = true
		
func on_resume_pressed():
	toggle_pause_menu()

func on_options_pressed():
	options_menu.show()

func on_exit_pressed():
	SaveData.save_data()
	get_tree().change_scene_to_file('res://main.tscn')
	toggle_pause_menu()

func btn_click():
	$MenuSelectionClick.play()

func _on_btn_exit_pressed() -> void:
	options_menu.hide()
