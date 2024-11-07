class_name PlayerState extends State

const IDLE = 'Idle'
const IDLE_PACKAGE = 'IdlePackage'
const WALK = 'Walk'
const WALK_PACKAGE = 'WalkPackage'
const DROP_PACKAGE = 'DropPackage'
const CALL = 'Call'

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, 'The player state type must be used only in the player scene. It needs the owner to be a Player node')
