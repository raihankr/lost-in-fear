extends BaseScene

signal car_arrived

@onready var car: AnimatedSprite2D = %Car/CarSprite
@onready var car_running_sound: AudioStreamPlayer2D = %CarRunningSound
@onready var car_stopping_sound: AudioStreamPlayer2D = %CarStoppingSound
@onready var global_camera: Camera2D = $GlobalCamera
@onready var animation: AnimationPlayer  = $AnimationPlayer

var living_room: String = 'res://scenes/world/living_room.tscn'
var video_path: String = "res://assets/videos/open_door.ogv"
var dialogue: Resource = preload("res://dialogues/outdoor.dialogue")
var car_prepare_to_stop: bool = false

func _ready():
	ResourceLoader.load_threaded_request(video_path)
	set_process(false)
	await super._setup()
	InGameUI.enable(true, false)
	var prolog = preload('res://scenes/subviews/prolog.tscn').instantiate()
	get_tree().current_scene.add_child(prolog)
	await prolog.find_child('AnimationPlayer').animation_finished
	prolog.queue_free()
	player.world_position = 'Spawn'
	player.hide()
	await super._fade_in()
	player.input_enabled = false
	follow_camera.make_current()
	await Global.wait(1)
	set_process(true)
	player.state_machine.enter('Idle')
	await car_arrived
	player.show()
	await player.move_to($StartingPoint.global_position, 50, 'WalkPackage')
	player.input_enabled = true
	DialogueManager.show_dialogue_balloon(dialogue, 'arrival')
	await DialogueManager.dialogue_ended
	Global.show_image_subview(preload("res://assets/images/interfaces/instruksi_1.png"))

func _process(delta: float):
	if animation.is_playing() and Input.is_action_just_pressed('skip_dialogue'):
		animation.stop(false)
		animation.animation_finished.emit()
	elif Input.is_key_pressed(KEY_ESCAPE) and OS.is_debug_build():
		set_process(false)
		next_scene()
	move_car(delta)
	
func move_car(delta: float) -> void:
	if (%CarPosition.progress_ratio < 1):
		car.play('moving')
		if not car_running_sound.playing and %CarPosition.progress_ratio < .6:
			car_running_sound.play()
		elif not car_prepare_to_stop and %CarPosition.progress_ratio > .6:
			car_stopping_sound.play()
			car_prepare_to_stop = true
		%CarPosition.progress += 100 * delta
	elif car.is_playing():
		car.stop()
		car_arrived.emit()

func _on_task_call_body_entered(body: Node) -> void:
	player.input_enabled = false
	player.head_rotation = 1.5 * PI
	await Global.wait(1)
	global_camera.make_current()
	animation.play('HouseOverview')
	await animation.animation_finished
	follow_camera.make_current()
	DialogueManager.show_dialogue_balloon(dialogue, 'call')
	await DialogueManager.dialogue_ended
	player.input_enabled = true
	$TaskGoInside.enable()

func _on_task_go_inside_body_entered(body: Node) -> void:
	player.head_rotation = 1.5 * PI
	DialogueManager.show_dialogue_balloon(dialogue, 'going_inside')
	await DialogueManager.dialogue_ended
	var video: VideoStream = ResourceLoader.load_threaded_get(video_path)
	await Global.show_video(video, $ContainerFront, false)
	next_scene()

func next_scene() -> void:
	SceneManager.change_scene(self, living_room,
		{'player': {'visible': true}}
	)
