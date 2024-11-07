extends BaseScene

signal car_arrived

@onready var car: AnimatedSprite2D = %Car/Sprite2D
@onready var player: Player = %Player
@onready var car_running_sound: AudioStreamPlayer2D = %CarRunningSound
@onready var car_stopping_sound: AudioStreamPlayer2D = %CarStoppingSound2

var living_room: PackedScene = preload('res://scenes/world/living_room.tscn')
var dialogue: Resource = preload("res://dialogues/scene_1.dialogue")
var car_prepare_to_stop: bool = false

func _ready():
	super()
	player.state_machine.enter('Idle')
	set_process(false)
	await Global.wait(1.5)
	set_process(true)
	await car_arrived
	player.show()
	await player.move_to(%StartingPoint.global_position, 50, 'WalkPackage')
	await DialogueManager.show_dialogue_balloon(dialogue, 'arrival')

func _process(delta):
	move_car(delta)
	
func move_car(delta):
	if (%CarPosition.progress_ratio < 1):
		car.play('moving')
		if not car_running_sound.playing and %CarPosition.progress_ratio < .6:
			car_running_sound.play()
		elif not car_prepare_to_stop and %CarPosition.progress_ratio > .6:
			car_stopping_sound.play()
			car_prepare_to_stop = true
		%CarPosition.progress += 100 * delta
	elif car.is_playing():
		car.frame = 0
		car_arrived.emit()
		car.pause()

func _on_task_call_body_entered(body):
	player.head_rotation = 1.5 * PI
	DialogueManager.show_dialogue_balloon(dialogue, 'call')
	await DialogueManager.dialogue_ended
	$TaskGoInside.enable()

func _on_task_go_inside_body_entered(body):
	player.head_rotation = 1.5 * PI
	DialogueManager.show_dialogue_balloon(dialogue, 'going_inside')
	await DialogueManager.dialogue_ended
	transition_to(living_room)
