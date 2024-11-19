extends BaseScene

var arrived_at_house: Resource = preload("res://scenes/events/arrived_at_house.tscn")
var action_triggered_dialogue: Resource = preload('res://dialogues/action_triggered.dialogue')

func _ready(setup_func: Callable = func(): pass):
	super()
	if not SaveData.data.events.has_entered_house:
		add_child(arrived_at_house.instantiate())

func _process(delta):
	pass

func _on_doorway_body_entered(body):
	DialogueManager.show_dialogue_balloon(action_triggered_dialogue, 'front_door_locked')
