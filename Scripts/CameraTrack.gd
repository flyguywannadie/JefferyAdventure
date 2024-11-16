@tool extends Node2D
class_name CamTrack

@export var trackBounds: Vector2
@onready var visuals: Sprite2D = $TrackVisualization

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (!Engine.is_editor_hint() && visuals.visible) :
		visuals.visible = false
		pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Engine.is_editor_hint()) :
		if (visuals.visible) :
			visuals.scale = trackBounds + Vector2(10,10)
			
	pass


func isVectorWithinBounds(given: Vector2) -> bool:
	return isXYWithinBounds(given.x, given.y)

func isVectorWithinABound(given: Vector2) -> bool:
	return isXYWithinABound(given.x, given.y)

func isXYWithinABound(givenX: float, givenY: float) -> bool:
	#print(isXWithinBounds(givenX), isYWithinBounds(givenY))
	return isXWithinBounds(givenX) || isYWithinBounds(givenY)

func isXYWithinBounds(givenX: float, givenY: float) -> bool:
	#print(isXWithinBounds(givenX), isYWithinBounds(givenY))
	return isXWithinBounds(givenX) && isYWithinBounds(givenY)

func isXWithinBounds(x: float) -> bool:
	return (x <= global_position.x + (trackBounds.x/2) && x >= global_position.x - (trackBounds.x/2))

func isYWithinBounds(y: float) -> bool:
	return (y <= global_position.y + (trackBounds.y/2) && y >= global_position.y - (trackBounds.y/2))




func placeVectorWithinBounds(given: Vector2) -> Vector2:
	return Vector2(placeXWithinBounds(given.x), placeYWithinBounds(given.y))

func placeXWithinBounds(x: float) -> float:
	return clampf(x, global_position.x - (trackBounds.x/2), global_position.x + (trackBounds.x/2))

func placeYWithinBounds(y: float) -> float:
	return clampf( y, global_position.y - (trackBounds.y/2), global_position.y + (trackBounds.y/2))
