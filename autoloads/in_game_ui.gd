extends CanvasLayer

@onready var inventory_slots = %Inventory

func _ready():
	Global.inventory_changed.connect(update_inventory)

func enable(enable: bool, show_inventory: bool = true):
	visible = enable
	set_process(enable)
	inventory_slots.visible = show_inventory

func update_inventory(inventory: Array):
	for idx in range(3):
		if inventory.size() > idx:
			inventory_slots.get_child(idx).item_name = inventory[idx][0]
			inventory_slots.get_child(idx).texture_node.texture = load(inventory[idx][1])
		else:
			inventory_slots.get_child(idx).item_name = ''
			inventory_slots.get_child(idx).texture_node.texture = null
