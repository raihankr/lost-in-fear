class_name PlayerState extends State

const IDLE: String = 'Idle'
const IDLE_FLASHLIGHT: String = 'IdleFlashlight'
const IDLE_PACKAGE: String = 'IdlePackage'
const WALK: String = 'Walk'
const WALK_fLASHLIGHT: String = 'WalkFlashlight'
const WALK_PACKAGE: String = 'WalkPackage'
const DROP_PACKAGE: String = 'DropPackage'
const CALL: String = 'Call'

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, 'The player state type must be used only in the player scene. It needs the owner to be a Player node')
