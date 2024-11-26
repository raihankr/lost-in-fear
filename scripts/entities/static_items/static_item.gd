class_name StaticItem extends Area2D

const OUTLINE_MATERIAL = preload("res://resources/materials/white_outline.tres")

@export var subview_image: Texture = null
@export var subview_scene: PackedScene = null
@export var dialogue: DialogueResource = null
@export var dialogue_title: String = ''

@onready var texture_node: Sprite2D = $Texture

func interact():
	if subview_scene:
		get_tree().current_scene.add_child(subview_scene.instantiate())
	elif subview_image:
		Global.show_image_subview(subview_image)
	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)

func _on_area_entered(area: Area2D):
	if area.is_in_group('action_area'):
		texture_node.material = OUTLINE_MATERIAL

func _on_area_exited(area: Area2D):
	if area.is_in_group('action_area'):
		texture_node.material = null
