extends Node2D

var rootScene

var evolutionScreen: EvolutionScreen #= $"../CanvasLayer/EvolutionScreen"
var deathScreen: DeathScreen #= $"../CanvasLayer/DeathScreenJeffery"

var startLevel: String = "TestFirstScene"
var currentLevel: Room
var prevLevel: Room

var prevJefferyPos: Vector2
var nextJefferyPos: Vector2
var prevCamPos: Vector2
var nextCamPos: Vector2
var moveCamJeff: bool = false
var movinglerp: float

var jeffery: Jeffery
var camera: GameCamera

var currentCheckpoint: Checkpoint

var gameState: String = ""
var piecesGotten: int = 0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	#
	#for child in get_tree().root.get_child(0).get_children():
		#if child is GameCamera:
			#camera = child
		#if child is Jeffery:
			#jeffery = child
	#call_deferred("addLevel", startLevel)
	#pass

func SetJeffery(jeff: Jeffery) -> void:
	jeffery = jeff

func GetJeffery() -> Jeffery:
	return jeffery

func SetGameCamera(cam: GameCamera) -> void:
	camera = cam

func GetGameCamera() -> GameCamera:
	return camera

func ChangeScene(filePath: String) -> void:
	endLevels()
	get_tree().change_scene_to_file(filePath)
	rootScene = get_tree().root.get_child(0)

func endLevels() -> void:
	if (currentLevel != null) :
		currentLevel.queue_free()
	pass

func addLevel(levelName: String) -> void:
	print(get_tree().root.get_child_count())
	prevLevel = currentLevel
	var level = load("res://Scenes/" + levelName + ".tscn").instantiate()
	rootScene.add_child(level)
	level.owner = rootScene
	currentLevel = level as Room
	pass

func SwapRoom(roomName: String, enterDirection: float):
	# pause the game
	PauseGame()
	# add the new level
	addLevel(roomName)
	currentLevel.gameStateChanges(gameState)
	# Set Up Movment variables for moving jeffery and camera between rooms smoothyl
	prevJefferyPos = jeffery.position
	nextJefferyPos = jeffery.position + Vector2(128 * 3, 0).rotated(enterDirection)
	prevCamPos = camera.position
	camera.changeTrack(currentLevel.getClosestTrack(camera.position))
	nextCamPos = camera.currentTrack.placeVectorWithinBounds(camera.position)
	# replace chackpoint with new checkpoint
	currentCheckpoint = currentLevel.getClosestCheckpoint(jeffery.position)
	# allow game manager to move jeffery and camera
	moveCamJeff = true
	pass

func endSwap() -> void:
	# stop letting gamemanger move things and reset some variables
	moveCamJeff = false
	movinglerp = 0
	camera.followOffset = Vector2(0,0)
	# remove previous level as it is no longer needed
	prevLevel.queue_free()
	# unpause the game
	ResumeGame()
	pass

func JefferyDie() -> void :
	jeffery.health = 2
	jeffery.position = currentCheckpoint.position
	jeffery.Reset()

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
			PiecePickedUp("d")
		if (Input.is_key_pressed(KEY_B)):
			PiecePickedUp("c")
		if (Input.is_key_pressed(KEY_N)):
			PiecePickedUp("f")
	
	pass

func PiecePickedUp(piece: String) -> void:
	PauseGame()
	AddToGameState(piece)
	piecesGotten += 1
	evolutionScreen.StartEvolution(piece)
	pass

func PauseGame():
	get_tree().paused = true

func ResumeGame():
	get_tree().paused = false

func AddToGameState(added: String) -> void:
	gameState += added
	pass
