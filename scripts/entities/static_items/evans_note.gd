extends "res://scripts/entities/static_items/dynamic_note.gd"

func interact():
	if not SaveData.data.events.has_seen_evan:
		SaveData.data.events.has_seen_evan = true
		await Global.show_video(ResourceLoader.load_threaded_get("res://assets/videos/mirror.ogv"),
			get_tree().current_scene.find_child('ContainerFront'))
	super()
