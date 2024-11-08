class_name MainMenu
extends Control

@onready var Btn_Start = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Start as Button
@onready var Btn_Options = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Options as Button
@onready var Options_Menu  = $Options_Menu as OptionsmMenu
@onready var Btn_Credits = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Credits as Button
@onready var Btn_Quit = $MarginContainer/HBoxContainer/VBoxContainer/Btn_Quit as Button
@onready var Load_Game = preload("res://scenes/world.tscn") as PackedScene
@onready var Margin_Container = $MarginContainer as MarginContainer

func _ready():
	handle_connecting_signals()
	
	
func _on_mouse_entered():
	$AudioStreamPlayer_Hover.play()
	
func on_option_pressed() -> void:
	Margin_Container.visible = false
	Options_Menu.set_process(true)
	Options_Menu.visible = true
	$AudioStreamPlayer_Click.play()
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(Load_Game)
	$AudioStreamPlayer_Click.play()

func on_exit_pressed() -> void:
	get_tree().quit()
	$AudioStreamPlayer_Click.play()
	
func on_exit_options_menu() -> void:
	Margin_Container.visible = true
	Options_Menu.visible = false
	$AudioStreamPlayer_Click.play()
	

func handle_connecting_signals() -> void:
		Btn_Start.button_down.connect("on_start_pressed", self, "_on_button_pressed")
		Btn_Start.button_down.connect("mouse_entered", self, "_on_mouse_entered")
		Btn_Options.button_down.connect("on_option_pressed", self, "_on_button_pressed")
		Btn_Options.button_down.connect("mouse_entered", self, "_on_mouse_entered")
		Btn_Quit.button_down.connect("on_exit_pressed", self, "_on_button_pressed")
		Btn_Quit.button_down.connect("mouse_entered", self, "_on_mouse_entered")
		Options_Menu.exit_options_menu.connect("on_exit_options_menu", self, "_on_button_pressed")
		Options_Menu.exit_options_menu.connect("mouse_entered", self, "_on_mouse_entered")
		
		
		
	
	
	



	
	
