class_name StaticItem extends Area2D

const OUTLINE_MATERIAL = preload("res://resources/materials/white_outline.tres")

@onready var texture_node: Sprite2D = $Texture

func interact():
	pass

func _on_area_entered(area: Area2D):
	if area.is_in_group('action_area'):
		texture_node.material = OUTLINE_MATERIAL

func _on_area_exited(area: Area2D):
	if area.is_in_group('action_area'):
		texture_node.material = null
