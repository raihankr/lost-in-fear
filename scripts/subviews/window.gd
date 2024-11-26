extends Subview

func _ready():
	super()
	if SaveData.data.events.has_opened_window_seal:
		texture_node.texture = preload("res://assets/images/subviews/wall_break_closeup_after.png")
