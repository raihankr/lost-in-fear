class_name StaticItem extends Area2D

const OUTLINE_MATERIAL = preload("res://resources/materials/white_outline.tres")

@onready var texture_node: Sprite2D = $Texture

var dialogue: Resource = preload('res://dialogues/action_triggered.dialogue')

func interact():
	pass

func _on_area_entered(area):
	texture_node.material = OUTLINE_MATERIAL

func _on_area_exited(area):
	texture_node.material = null
