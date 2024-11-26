class_name Subview extends CanvasLayer

@onready var texture_node: TextureRect = self.get_node_or_null('Texture')

func _ready():
	if 'player' in get_tree().current_scene:
		get_tree().current_scene.player.input_enabled = false

func _process(delta):
	Global.subview_visible = true

func _exit_tree():
	Global.subview_visible = false

func _on_close_button_pressed():
	get_tree().current_scene.player.input_enabled = true
	Global.subview_closed.emit()
	queue_free()
