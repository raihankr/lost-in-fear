extends CanvasLayer

@onready var inventory_slots: HBoxContainer = %Inventory
@onready var toast: Label = %Toast
@onready var toast_timer: Timer = %Toast/Timer

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

func show_toast(text: String, time_sec: int = 3):
	toast.text = text
	toast_timer.start(time_sec)
	toast.show()
	await toast_timer.timeout
	var tween: Tween = create_tween()
	tween.tween_property(toast, 'modulate', Color.TRANSPARENT, .5)
	await tween.finished
	toast.hide()
	toast.modulate = Color.WHITE
	
