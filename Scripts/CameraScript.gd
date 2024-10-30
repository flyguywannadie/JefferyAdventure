extends Camera2D
class_name GameCamera

@export var toFollow: Jeffery
var followOffset: Vector2
var followPreviousPosition: Vector2
@export var currentTrack: CamTrack

var changeProgress: float = 0.0

# screen shake stuff
@export var shakeIntensity: float = 0.0
var shakeOffset: Vector2
var shakeAmount : Vector2 = Vector2(50.0,50.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.SetGameCamera(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (shakeIntensity > 0) :
		shakeIntensity -= delta
		shakeOffset = shakeAmount * shakeIntensity
		
		
	
	if (currentTrack != null && toFollow != null):
		# move the camera to desired location relative to player
		#var motion: Vector2 = toFollow.position - followPreviousPosition
		
		
		# add offset to camera based on where jeffery is going
		#print(motion) 
		#motion.x = abs(motion.x * 2)
		#if (toFollow.getFacingDirection()):
			#motion.x *= -1
		#followOffset += motion * 0.5
		#if (absf(followOffset.x) > 200) :
			#followOffset.x = sign(followOffset.x) * 200
		#
		#if (absf(followOffset.y) > 200) :
			#followOffset.y = sign(followOffset.y) * 200
		
		followOffset = lerp(followOffset, Vector2.ZERO, changeProgress)
		changeProgress += 1 * delta
		changeProgress = clampf(changeProgress,0, 1)
		
		# put the new relative position within the bounds the camera should be moving around
		#if (currentTrack.isVectorWithinBounds(toFollow.position+ followOffset)):
		position = currentTrack.placeVectorWithinBounds(toFollow.position) + followOffset
		
		#followPreviousPosition = toFollow.position
	position += shakeOffset
	pass

func ScreenShake(dir: Vector2, intensity: float):
	shakeIntensity = intensity
	shakeAmount = dir * 50.0
	pass

func changeTrack(newTrack: CamTrack) -> void:
	currentTrack = newTrack
	changeProgress = 0.0
	followOffset = position - currentTrack.placeVectorWithinBounds(toFollow.position)
	pass
