extends CanvasLayer

@onready var texture_node: TextureRect = %Texture

func _on_close_button_pressed():
	queue_free()
