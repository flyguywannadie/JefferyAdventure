extends Node2D

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

var gameState: String = ""
var piecesGotten: int = 0

var gameOver

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

func MakeFirstScene() -> void:
	await Signal(get_tree().create_timer(0.01), "timeout")
	gameState = ""
	call_deferred("addLevel", "TestFirstScene")

func endLevels() -> void:
	if (currentLevel != null) :
		currentLevel.queue_free()
	pass

func resetLevel():
	print(currentLevel.scene_file_path)
	var level = load(currentLevel.scene_file_path).instantiate()
	currentLevel.queue_free()
	get_tree().root.get_node("Node2D").add_child(level)
	level.owner = get_tree().root.get_node("Node2D")
	currentLevel = level as Room
	camera.changeTrack(currentLevel.getClosestTrack(camera.position))

func addLevel(levelName: String) -> void:
	prevLevel = currentLevel
	var level = load("res://Scenes/" + levelName + ".tscn").instantiate()
	get_tree().root.get_node("Node2D").add_child(level)
	level.owner = get_tree().root.get_node("Node2D")
	currentLevel = level as Room

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
	# allow game manager to move jeffery and camera
	moveCamJeff = true

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

func JefferyGameOver() -> void :
	#jeffery.position = currentCheckpoint.position
	deathScreen.BeginGameOver()

func JefferyRetry() -> void:
	ResumeGame()
	
	jeffery.global_position = currentLevel.getCheckpointPosition()
	camera.global_position = currentLevel.getCheckpointPosition()
	resetLevel()
	
	jeffery.call_deferred("Reset")

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
