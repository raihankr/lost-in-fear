extends PadlockSlot

const TEXTURE: Array[Texture] = [
	preload("res://resources/textures/shapes/circle.tres"),
	preload("res://resources/textures/shapes/diamond.tres"),
	preload("res://resources/textures/shapes/half_circle.tres"),
	preload('res://resources/textures/shapes/polygon.tres'),
	preload("res://resources/textures/shapes/square.tres"),
	preload("res://resources/textures/shapes/triangle.tres")
]

@onready var display: TextureRect = $Display

func _ready():
	display.texture = TEXTURE[value]

func _on_value_changed(value: int):
	display.texture = TEXTURE[value]
