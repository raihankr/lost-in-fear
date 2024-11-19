extends Node

const DEBUG_MENU = preload('res://scenes/debug/menu.tscn')
const PROD_MENU = preload('res://scenes/main_menu.tscn')

func _ready():
	InGameUI.enable(false)
	if ProjectSettings.get_setting_with_override('environment/debug_mode'):
		get_tree().change_scene_to_packed(DEBUG_MENU)
	else:
		get_tree().change_scene_to_packed(PROD_MENU)
