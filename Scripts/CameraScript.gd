extends Camera2D
class_name GameCamera

@export var toFollow: Jeffery
var followOffset: Vector2
var followPreviousPosition: Vector2
@export var currentTrack: CamTrack

var trackChanged: bool = false
var changeProgress: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (currentTrack && toFollow.position != followPreviousPosition && !trackChanged):
		# move the camera to desired location relative to player
		var motion: Vector2 = toFollow.position - followPreviousPosition
		
		
		# add offset to camera based on where jeffery is going
		#print(motion) 
		#motion.x = abs(motion.x * 2)
		#if (toFollow.getFacingDirection()):
			#motion.x *= -1
		followOffset += motion
		
		if (absf(followOffset.x) > 200) :
			followOffset.x = sign(followOffset.x) * 200
		
		if (absf(followOffset.y) > 200) :
			followOffset.y = sign(followOffset.y) * 200
		
		# put the new relative position within the bounds the camera should be moving around
		#if (currentTrack.isVectorWithinBounds(toFollow.position+ followOffset)):
		position = currentTrack.placeVectorWithinBounds(toFollow.position + followOffset)
		
		followPreviousPosition = toFollow.position
	
	if (trackChanged) :
		position = lerp(position, currentTrack.placeVectorWithinBounds(toFollow.position + followOffset), changeProgress)
		
		changeProgress += delta
		
		if (currentTrack.isVectorWithinBounds(position)):
			trackChanged = false
			print("track done changing")
		
		pass
	
	
	
	pass

func changeTrack(newTrack: CamTrack) -> void:
	trackChanged = true
	currentTrack = newTrack
	changeProgress = 0.0
	pass