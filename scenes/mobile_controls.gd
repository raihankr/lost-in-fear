extends CanvasLayer

func _ready():
	if OS.get_name() not in ['Android', 'iOS']:
		queue_free()
