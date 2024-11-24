extends Node2D

var evolutionScreen: EvolutionScreen #= $"../CanvasLayer/EvolutionScreen"
var deathScreen: DeathScreen #= $"../CanvasLayer/DeathScreenJeffery"
var bossHealthbar: BossHealthbar

var startLevel: String = "StorageRoom"
var currentLevel: Room
var prevLevel: Room

var projectileOwner: Node2D

var prevJefferyPos: Vector2
var nextJefferyPos: Vector2
var prevCamPos: Vector2
var nextCamPos: Vector2
var moveCamJeff: bool = false
var movinglerp: float

var checkpoint: Node2D

var levelResetPosition: Vector2

var jeffery: Jeffery
var camera: GameCamera

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

func SetCheckpoint(point: Node2D) -> void:
	checkpoint = point

func SetJeffery(jeff: Jeffery) -> void:
	jeffery = jeff

func GetJeffery() -> Jeffery:
	return jeffery

func SetGameCamera(cam: GameCamera) -> void:
	camera = cam

func GetGameCamera() -> GameCamera:
	return camera

func StartCutscene() -> void:
	jeffery.RemoveControl()

func EndCutscene() -> void:
	jeffery.ReturnControl()

func ChangeScene(filePath: String) -> void:
	endLevels()
	get_tree().change_scene_to_file(filePath)

func MakeFirstScene() -> void:
	await Signal(get_tree().create_timer(0.01), "timeout")
	projectileOwner = get_tree().root.get_node("Node2D")
	gameState = ""
	piecesGotten = 0
	call_deferred("addLevel", startLevel)
	call_deferred("firstLevelStuff")

func firstLevelStuff() -> void:
	camera.changeTrack(currentLevel.getClosestTrack(jeffery.global_position), false)
	camera.global_position = camera.currentTrack.placeVectorWithinBounds(jeffery.global_position)
	currentLevel.EnableDoorways()

func endLevels() -> void:
	if (currentLevel != null) :
		currentLevel.queue_free()
	pass

func resetLevel():
	var level = load(currentLevel.scene_file_path).instantiate()
	currentLevel.queue_free()
	projectileOwner.add_child(level)
	level.owner = projectileOwner
	currentLevel = level as Room
	currentLevel.position = levelResetPosition
	currentLevel.gameStateChanges(gameState)
	camera.changeTrack(currentLevel.getClosestTrack(checkpoint.global_position), false)
	camera.global_position = camera.currentTrack.placeVectorWithinBounds(checkpoint.global_position)
	currentLevel.EnableDoorways()

func addLevel(levelName: String) -> void:
	prevLevel = currentLevel
	var level = load("res://Scenes/" + levelName + ".tscn").instantiate()
	projectileOwner.add_child(level)
	level.owner = projectileOwner
	currentLevel = level as Room

func SwapRoom(roomName: String, enterDirection: float, entranceID: int):
	# pause the game
	PauseGame()
	# add the new level
	addLevel(roomName)
	#jeffery.process_mode = Node.PROCESS_MODE_DISABLED
	currentLevel.gameStateChanges(gameState)
	var prevEntrance = prevLevel.getEntranceWithID(entranceID)
	var newEntrance = currentLevel.getEntranceWithID(entranceID)
	#print(prevEntrance.global_position, " and ", newEntrance.global_position)
	currentLevel.position += prevEntrance.global_position - newEntrance.global_position
	#print(currentLevel.global_position)
	levelResetPosition = currentLevel.position
	checkpoint = newEntrance.closestCheckpoint
	# Set Up Movment variables for moving jeffery and camera between rooms smooth
	prevJefferyPos = jeffery.global_position
	nextJefferyPos = jeffery.global_position + Vector2(128 * 3, 0).rotated(enterDirection)
	prevCamPos = camera.position
	camera.changeTrack(newEntrance.closestCameraTrack, false)
	nextCamPos = camera.currentTrack.placeVectorWithinBounds(camera.position)
	# allow game manager to move jeffery and camera
	moveCamJeff = true

func endSwap() -> void:
	# stop letting gamemanger move things and reset some variables
	moveCamJeff = false
	movinglerp = 0
	#jeffery.process_mode = Node.PROCESS_MODE_INHERIT
	camera.changeTrack(camera.currentTrack, true)
	#camera.followOffset = Vector2(0,0)
	# remove previous level as it is no longer needed
	prevLevel.queue_free()
	# enable the new doorways
	currentLevel.EnableDoorways()
	# unpause the game
	ResumeGame()
	pass

func BossHealthbarSetup(boss: Boss) -> void:
	bossHealthbar.bossITrack = boss
	bossHealthbar.Appear()

func BossDied() -> void:
	bossHealthbar.Hide()

func JefferyGameOver() -> void :
	#jeffery.position = currentCheckpoint.position
	deathScreen.BeginGameOver()

func JefferyRetry() -> void:
	ResumeGame()
	
	jeffery.global_position = checkpoint.global_position
	resetLevel()
	
	jeffery.call_deferred("Reset")

func _physics_process(delta: float) -> void:
	if(moveCamJeff):
		movinglerp += 1.0/(60.0 * 1.5)
		movinglerp = minf(movinglerp, 1.0)
		jeffery.position = lerp(prevJefferyPos, nextJefferyPos, movinglerp)
		camera.position = lerp(prevCamPos, nextCamPos, movinglerp)
		
		if (movinglerp == 1) :
			endSwap()

func ShakeScreenDirection(emitterpos: Vector2, intensity: float, duration: float) -> void:
	camera.ScreenShake((jeffery.global_position - emitterpos).normalized(), intensity, duration)

func ShakeScreen(intensity: float , duration: float) -> void:
	camera.ScreenShake(Vector2(randf_range(-1.0, 1.0),randf_range(-1.0, 1.0)).normalized(), intensity, duration)

func _input(event: InputEvent) -> void:
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

func CheckGameState(check: String) -> bool:
	return gameState.contains(check)
