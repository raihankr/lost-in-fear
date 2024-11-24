extends "res://scripts/interfaces/padlock_slot.gd"

@onready var display: Label = $Display

func _ready():
	display.text = str(value)

func _on_value_changed(value: int):
	display.text = str(value)
