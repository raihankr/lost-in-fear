extends VideoStreamPlayer

@export var free_on_finished: bool = true

func _ready():
	await finished
	if free_on_finished:
		queue_free()
