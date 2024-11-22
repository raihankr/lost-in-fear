extends CanvasLayer

@onready var target: Area2D = %Target

func _ready():
	if (Global.has_inventory('block_puzzle')):
		Global.dump_inventory(Global.find_inventory('block_puzzle'))

func _on_target_body_entered(body: Node):
	if body.is_in_group('main_block'):
		if not SaveData.data.events.has_solved_block_puzzle:
			Global.add_inventory(['storage_hint', '"res://assets/images/item/written-note.png"', 'Catatan'])

func _on_button_pressed():
	queue_free()
