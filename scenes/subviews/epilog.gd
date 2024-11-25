extends CanvasLayer

signal animation_finished

func _ready():
	InGameUI.enable(false, false)
	await $AnimationPlayer.animation_finished
	animation_finished.emit()
