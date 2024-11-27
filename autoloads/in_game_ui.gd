extends CanvasLayer

@onready var inventory_slots: HBoxContainer = %Inventory
@onready var toast: Label = %Toast
@onready var toast_timer: Timer = %Toast/Timer
@onready var item_popup: PanelContainer = %ItemPopup
@onready var item_popup_text: Label = %PopupText
@onready var item_popup_texture: TextureRect = %PopupTexture
@onready var item_popup_timer: Timer = %ItemPopup/Timer

func _ready():
	Global.inventory_changed.connect(update_inventory)

func _shortcut_input(event: InputEvent):
	if event.is_action_pressed('pause', true) and not Global.subview_visible:
		$PauseScreen.toggle_pause_menu()

func enable(enable: bool, show_inventory: bool = true):
	visible = enable
	set_process(enable)
	if is_instance_valid(MobileControls):
		MobileControls.visible = enable
		MobileControls.set_process(enable)
	inventory_slots.visible = show_inventory

func update_inventory(inventory: Array):
	for idx in range(3):
		if inventory.size() > idx:
			inventory_slots.get_child(idx).item_id = inventory[idx][0]
			inventory_slots.get_child(idx).texture_node.texture = load(inventory[idx][1])
			inventory_slots.get_child(idx).item_name = inventory[idx][2]
		else:
			inventory_slots.get_child(idx).item_id = ''
			inventory_slots.get_child(idx).texture_node.texture = null
			inventory_slots.get_child(idx).item_name = ''

func show_toast(text: String, time_sec: int = 2):
	toast.text = text
	toast_timer.start(time_sec)
	toast.show()
	await toast_timer.timeout
	var tween: Tween = create_tween()
	tween.tween_property(toast, 'modulate', Color.TRANSPARENT, .5)
	await tween.finished
	toast.hide()
	toast.modulate = Color.WHITE

func notify(text: String, icon: Variant = null, time_sec: int = 2):
	item_popup_text.text = text
	item_popup_texture.texture = icon
	item_popup_timer.start(time_sec)
	item_popup.show()
	await item_popup_timer.timeout
	var tween: Tween  = create_tween()
	tween.tween_property(item_popup, 'modulate', Color.TRANSPARENT, .5)
	await tween.finished
	item_popup.hide()
	item_popup.modulate = Color.WHITE
