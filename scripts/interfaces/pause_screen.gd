extends CanvasLayer

@onready var BtnResume = $PauseMenuContainer/PanelContainer/MarginContainer/Rows/BtnResume as Button
@onready var BtnOptions = $PauseMenuContainer/PanelContainer/MarginContainer/Rows/BtnOptions as Button
@onready var BtnExit = $PauseMenuContainer/PanelContainer/MarginContainer/Rows/BtnExit as Button

@onready var options_menu: Control = $Options_Menu

func _ready():
	BtnResume.pressed.connect(on_resume_pressed)
	BtnOptions.pressed.connect(on_options_pressed)
	BtnExit.pressed.connect(on_exit_pressed)
	
	options_menu.z_index = 10
	add_child(options_menu)
	
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
	pass
	
func btn_click():
	$MenuSelectionClick	.play()


func _on_btn_exit_pressed() -> void:
	options_menu.hide()
