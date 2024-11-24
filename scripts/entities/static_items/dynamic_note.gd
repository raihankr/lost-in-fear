extends StaticItem

@export var text: String = ''

func _ready():
	subview_scene = preload("res://scenes/subviews/note_subview.tscn")

func interact():
	var subview: CanvasLayer  = subview_scene.instantiate()
	subview.text = text
	get_tree().current_scene.add_child(subview)
