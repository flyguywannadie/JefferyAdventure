extends Node2D
class_name Room

@export var camTracks: Array[CamTrack]

var transitionStep: int = 0
var timer: float = 1
var prevJeffPos: Vector2
var nextJeffPos: Vector2
var prevCamPos: Vector2
var camLerp: float = 0

var camera: GameCamera
var jeffery: Jeffery
var gamemanager: GameManager

func _ready() -> void:
	for child in get_tree().root.get_child(0).get_children():
		if child is GameCamera:
			camera = child
		if child is Jeffery:
			jeffery = child
		if child is GameManager:
			gamemanager = child
	
	transitionStep = 0

func _physics_process(delta: float) -> void:
	match (transitionStep):
		1: # Wait a bit
			#timer -= delta
			#if (timer <= 0) :
				#timer = 1
				#transitionStep = 2
			pass
		2: # load next room
			pass
		3: # Move Jeffery and Camera to new positions
			#camLerp += 1.0/60.0
			#jeffery.position = lerp(prevJeffPos, nextJeffPos, camLerp)
			#camera.position = lerp(prevCamPos, nextJeffPos, camLerp)#camera.currentTrack.placeVectorWithinBounds(camera.position), camLerp)
			#
			#if (camLerp >= 1):
				#transitionStep = 3
			pass
		4: # unload previous room
			#print("PISS")
			pass

func _on_body_entered(body: Node2D) -> void:
	
	if (body == jeffery && !get_tree().paused) :
		get_tree().paused = true
		transitionStep = 1
		prevCamPos = camera.position
		#camera.changeTrack(nextRoom.getClosestTrack(prevCamPos))
		prevJeffPos = jeffery.position
		nextJeffPos = jeffery.position + (Vector2(128 * 4, 0).rotated(rotation))
	
	pass # Replace with function body.

func getClosestTrack(pos: Vector2) -> CamTrack:
	var closest: CamTrack = null
	
	for track in camTracks:
		if (closest == null):
			closest = track
		elif (pos.distance_to(track.position) < pos.distance_to(closest.position)):
			closest = track
	
	return closest
