extends Node

const ITEM_COMBINATION: Dictionary = {

}

signal inventory_selected(idx: Variant)
signal inventory_changed(inventory: Array)

var selected_inventory: Variant = null:
	set(value):
		selected_inventory = value
		inventory_selected.emit(value)
var inventory: Array = SaveData.data.inventory

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func add_inventory(item: Array[String]):
	inventory.append(item)
	inventory_changed.emit(inventory)

func drop_inventory(idx: int):
	inventory.remove_at(idx)
	inventory_changed.emit(inventory)
