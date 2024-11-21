extends CanvasLayer

@onready var texture_node: TextureRect = %Texture

func _ready():
	get_tree().current_scene.player.input_enabled = false

func _on_close_button_pressed():
	get_tree().current_scene.player.input_enabled = true
	queue_free()
