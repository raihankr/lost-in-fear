extends BaseScene

signal car_arrived

@onready var car = %Car/Sprite2D
@onready var player = %Player

var living_room = preload('res://scenes/living_room.tscn')
var dialogue = preload("res://dialogues/scene_1.dialogue")

func _ready():
	super()
	player.state_machine.enter('Idle')
	set_process(false)
	await Global.wait(3)
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
