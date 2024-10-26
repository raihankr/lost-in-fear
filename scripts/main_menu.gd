class_name MainMenu
extends Control

@onready var Btn_Start = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Start as Button
@onready var Btn_Options = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Options as Button
@onready var Btn_Credits = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Credits as Button
@onready var Btn_Quit = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Quit as Button


func _ready():
	handle_connecting_signals()
	
func on_option_pressed() -> void:
	print("LOAD OPTIONS MENU")

func on_exit_pressed() -> void:
	get_tree().quit()
	
func handle_connecting_signals() -> void:
		Btn_Quit.button_down.connect(on_exit_pressed)
		Btn_Options.button_down.connect(on_option_pressed)
	
	
	



	
	
