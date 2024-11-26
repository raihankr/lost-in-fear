class_name Subview extends CanvasLayer

@export var touch_anywhere_to_close: bool = false

@onready var texture_node: TextureRect = self.get_node_or_null('Texture')

func _ready():
	if 'player' in get_tree().current_scene:
		get_tree().current_scene.player.input_enabled = false

func _process(delta):
	Global.subview_visible = true
	if touch_anywhere_to_close:
		print('yes')
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			_on_close_button_pressed()

func _exit_tree():
	Global.subview_visible = false

func _on_close_button_pressed():
	get_tree().current_scene.player.input_enabled = true
	Global.subview_closed.emit()
	queue_free()
