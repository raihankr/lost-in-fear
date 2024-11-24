class_name StaticItem extends Area2D

const OUTLINE_MATERIAL = preload("res://resources/materials/white_outline.tres")

@export var subview: Texture = null
@export var dialogue: DialogueResource = null
@export var dialogue_title: String = ''

@onready var texture_node: Sprite2D = $Texture

var subview_data: Dictionary = {}

func interact():
	if subview:
		Global.show_image_subview(subview, subview_data)
	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)

func _on_area_entered(area: Area2D):
	if area.is_in_group('action_area'):
		texture_node.material = OUTLINE_MATERIAL

func _on_area_exited(area: Area2D):
	if area.is_in_group('action_area'):
		texture_node.material = null
