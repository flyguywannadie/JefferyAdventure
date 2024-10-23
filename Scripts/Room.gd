extends Node2D
class_name Room

@export var camTracks: Array[CamTrack]
@export var checkpoints: Array[Checkpoint]
#@export var entrances: Array[Doorway]
@export var stateChanges: Node2D

func _ready() -> void:
	pass

func getClosestTrack(pos: Vector2) -> CamTrack:
	var closest: CamTrack = null
	
	for track in camTracks:
		if (closest == null):
			closest = track
		elif (pos.distance_to(track.position) < pos.distance_to(closest.position)):
			closest = track
	
	return closest

func getClosestCheckpoint(pos: Vector2) -> Checkpoint:
	var closest: Checkpoint = null
	
	for check in checkpoints:
		if (closest == null):
			closest = check
		elif (pos.distance_to(check.position) < pos.distance_to(closest.position)):
			closest = check
	
	return closest

func leaveRoom(roomName: String, entranceDirection: float) -> void:
	GameManager.SwapRoom(roomName, entranceDirection)
	pass

func gameStateChanges(gamestate: String) -> void:
	# upon the room being loaded, change things based on the game state
	# I can probably do something better than this with some seperate script that this functi#on will check through
	# just keep this here for thinking, should be updated with next week's level creation thinking
	
	if (stateChanges == null) :
		return
	
	if (stateChanges.get_child_count() == 0):
		return
	
	for change in stateChanges.get_children():
		change.visible = true
		change.call("CheckCondition", gamestate)
	
	## ds = Deadly Sword
	#if (gamestate.contains("ds")):
		#pass
	## cs = Charge Sword
	#if (gamestate.contains("cs")):
		#pass
	## fs = Fast Sword
	#if (gamestate.contains("fs")):
		#pass
	## dg = Deadly Gun
	#if (gamestate.contains("dg")):
		#pass
	## cg = Charge Gun
	#if (gamestate.contains("cg")):
		#pass
	## fg = Fast Gun
	#if (gamestate.contains("fg")):
		#pass
	pass
