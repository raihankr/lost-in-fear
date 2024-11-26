class_name PadlockSubview extends "res://scripts/subviews/image_subview.gd"

signal completed

@export var pin: Array[int] = [0, 0, 0]
@export var current_digits: Array[int] = [0, 0, 0]

func _ready():
	super()
	current_digits.resize(pin.size())
	for child in $Padlocks.get_children():
		(child as PadlockSlot).value_changed.connect(on_value_changed)
		child.value = current_digits[child.get_index()]

func on_value_changed(value: int):
	for child in $Padlocks.get_children():
		current_digits[child.get_index()] = child.value
	if current_digits == pin:
		completed.emit()
		queue_free()
