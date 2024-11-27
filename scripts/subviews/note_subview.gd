extends "res://scripts/subviews/image_subview.gd"

@export_multiline	 var text: String = ''

func _ready():
	%Text.text = text
