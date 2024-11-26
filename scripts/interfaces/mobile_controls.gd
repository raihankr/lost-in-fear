extends CanvasLayer

func _ready():
	if OS.get_name() not in ['Android', 'iOS']:
		queue_free()
	show()


func _on_pause_button_pressed():
	Input.action_press('pause')


func _on_interact_button_pressed():
	Input.action_press('interact')


func _on_interact_button_button_down():
	$InteractButton.modulate = Color(.5, .5, .5, .6)

func _on_interact_button_button_up():
	$InteractButton.modulate = Color(1, 1, 1, .6 )
