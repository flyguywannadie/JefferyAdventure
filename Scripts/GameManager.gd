extends Node2D
class_name GameManager

@onready var evolution_screen: EvolutionScreen = $"../CanvasLayer/EvolutionScreen"

@onready var startLevel: String = "TestFirstScene"
var currentLevel: Room
var prevLevel: Room

var prevJefferyPos: Vector2
var nextJefferyPos: Vector2
var prevCamPos: Vector2
var nextCamPos: Vector2
var moveCamJeff: bool = false
var movinglerp: float

@export var jeffery: Jeffery
@export var camera: GameCamera

var gameState: String = ""
var piecesGotten: int = 0

func _ready() -> void:
	for child in get_tree().root.get_child(0).get_children():
		if child is GameCamera:
			camera = child
		if child is Jeffery:
			jeffery = child
	call_deferred("addLevel", startLevel)
	pass

func endLevels() -> void:
	currentLevel.queue_free()
	pass

func addLevel(levelName: String) -> void:
	prevLevel = currentLevel
	var level = load("res://Scenes/" + levelName + ".tscn").instantiate()
	owner.add_child(level)
	level.owner = owner
	currentLevel = level as Room
	pass

func swapRoom(roomName: String, entranceDirection: float):
	# pause the game
	get_tree().paused = true
	# add the new level
	addLevel(roomName)
	currentLevel.gameStateChanges(gameState)
	# move jeffery and camera to the new room
	prevJefferyPos = jeffery.position
	nextJefferyPos = jeffery.position + Vector2(128 * 3, 0).rotated(entranceDirection)
	prevCamPos = camera.position
	camera.changeTrack(currentLevel.getClosestTrack(camera.position))
	nextCamPos = camera.currentTrack.placeVectorWithinBounds(camera.position)
	moveCamJeff = true
	pass

func endSwap() -> void:
	moveCamJeff = false
	movinglerp = 0
	camera.followOffset = Vector2(0,0)
	# remove previous level
	prevLevel.queue_free()
	# unpause the game
	get_tree().paused = false
	pass

func _physics_process(delta: float) -> void:
	if(moveCamJeff):
		movinglerp += 1.0/(60.0 * 1.5)
		jeffery.position = lerp(prevJefferyPos, nextJefferyPos, movinglerp)
		camera.position = lerp(prevCamPos, nextCamPos, movinglerp)
		
		if (movinglerp > 1) :
			endSwap()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#print(gameState)
	if (!get_tree().paused) :
		if (Input.is_key_pressed(KEY_V)):
			StartEvolution("d")
		if (Input.is_key_pressed(KEY_B)):
			StartEvolution("c")
		if (Input.is_key_pressed(KEY_N)):
			StartEvolution("f")
	
	pass

func StartEvolution(piece: String) -> void:
	get_tree().paused = true
	gameState += piece
	piecesGotten += 1
	evolution_screen.StartEvolution(piece)
	pass
