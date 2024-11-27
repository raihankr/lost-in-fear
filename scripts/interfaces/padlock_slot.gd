class_name PadlockSlot extends VBoxContainer

signal value_changed(value: int)

@export var value: int = 1
@export var min: int = 1
@export var max: int = 9

func next_digit():
	value +=  1
	if value > max:
		value = min
	value_changed.emit(value)

func previous_digit():
	value -= 1
	if value < min:
		value = max
	value_changed.emit(value)
