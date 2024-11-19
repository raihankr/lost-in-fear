class_name Item extends Area2D

const OUTLINE_MATERIAL = preload("res://resources/materials/white_outline.tres")

@export var item_name: String

@onready var texture_node: Sprite2D = $Texture
@onready var texture: Texture = $Texture.texture

var dialogue: Resource = preload('res://dialogues/action_triggered.dialogue')

func _save_to_inventory():
	Global.add_inventory([item_name, texture.resource_path])
	queue_free()

func pick_up(save_to_inventory: bool = true) -> void:
	if Global.inventory.size() < 3:
		if save_to_inventory:
			_save_to_inventory()
	else:
		DialogueManager.show_dialogue_balloon(dialogue, 'inventory_full')

func on_dropped(at_position: Vector2, data: Variant) -> void:
	pass

 func _on_area_entered(area: Area2D):
	if area.is_in_group('action_area'):
		texture_node.material = OUTLINE_MATERIAL

func _on_area_exited(area: Area2D):
	if area.is_in_group('action_area'):
		texture_node.material = null
