extends BaseScene

func _setup():
	ResourceLoader.load_threaded_request("res://assets/videos/mirror.ogv")
	super()
