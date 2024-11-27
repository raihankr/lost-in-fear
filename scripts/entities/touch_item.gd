extends TextureButton

@export var item_id: String = ''
@export_file('*.png') var item_icon: String = ''
@export var item_name: String = ''
@export var event_name: String = 'has_'

func _ready():
	if SaveData.data.events[event_name]:
		queue_free()

func _pressed():
	Global.add_inventory([item_id, item_icon, item_name])
	SaveData.data.events[event_name] = true
	queue_free()
