class_name OptionsmMenu
extends Control

@onready var Btn_Exit = $MarginContainer/VBoxContainer/Btn_Exit as Button

signal exit_options_menu

func _ready():
	Btn_Exit.button_down.connect(on_exit_pressed)
	set_process(false)
	
	
func on_exit_pressed() -> void:
	exit_options_menu.emit()
	set_process(false)
