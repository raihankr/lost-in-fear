extends TextureButton

@export var item_id: String = ''
@export var item_icon: Texture = null
@export var item_name: String = ''

func _pressed():
	#Global.add_inventory([item_id, item_icon, item_name])
	pass
