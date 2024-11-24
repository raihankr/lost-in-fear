extends StaticItem

@export var text: String = '':
	set(value):
		subview_data.text = text

func interact():
	super()
