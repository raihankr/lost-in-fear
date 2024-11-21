extends BaseScene

signal just_got_flashlight

var arrived_at_house: PackedScene = preload("res://scenes/events/arrived_at_house.tscn")
var monika_appearance: PackedScene = preload('res://scenes/events/monika_appearance.tscn')
var dialogue: Resource = preload('res://dialogues/living_room.dialogue')

func _ready(setup_func: Callable = func(): pass):
	await super._setup()
	just_got_flashlight.connect(start_monika_appearance)
	if not SaveData.data.events.has_entered_house:
		self.add_child(arrived_at_house.instantiate())
	else:
		await super._fade_in()

func _process(delta):
	pass

func _on_doorway_body_entered(body):
	DialogueManager.show_dialogue_balloon(dialogue, 'front_door_locked')

func start_monika_appearance():
	if not SaveData.data.events.has_seen_monika:
		add_child(monika_appearance.instantiate())
