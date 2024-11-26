extends Camera2D
class_name GameCamera

@export var toFollow: Jeffery
var followOffset: Vector2
var followPreviousPosition: Vector2
@export var currentTrack: CamTrack

var changeProgress: float = 0.0

# screen shake stuff
@export var shakeTime: float = 0.0
var shakeOffset: Vector2
@export var noise: FastNoiseLite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.SetGameCamera(self)
	pass # Replace with function body.

#func _input(event: InputEvent) -> void:
	#if (event.is_action("jef_up")) :
		#ScreenShake(Vector2(1,1), 2.0, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (shakeTime > 0) :
		shakeTime -= delta
		shakeOffset = lerp( Vector2(0,0), Vector2(shakeOffset.y + noise.get_noise_1d(shakeOffset.x),shakeOffset.x + noise.get_noise_1d(shakeOffset.y)), shakeTime)

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
	position = position.floor()
	pass

func ScreenShake(dir: Vector2, intensity: float, duration: float):
	shakeTime = duration
	shakeOffset = dir.normalized() * intensity * 50.0
	pass

func changeTrack(newTrack: CamTrack, smoothTransition: bool) -> void:
	currentTrack = newTrack
	if (!smoothTransition):
		return
	changeProgress = 0.0
	followOffset = position - currentTrack.placeVectorWithinBounds(toFollow.position)
