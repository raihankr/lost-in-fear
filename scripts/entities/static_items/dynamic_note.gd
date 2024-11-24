extends StaticItem

@export var text: String = '':
	set(value):
		text = value
		subview_data.text = text
