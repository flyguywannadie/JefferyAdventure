extends Enemy
class_name Boss

var jeffery: Jeffery

@export var pieceIHold : String

@export var projectiles: Array[PackedScene]

var gameProgress: int

func _ready() -> void:
	
	jeffery = GameManager.jeffery
	
	match(randi_range(0, 2)):
		0:
			pieceIHold = "d"
		1:
			pieceIHold = "c"
		2:
			pieceIHold = "f"
	
	super._ready()
	pass

func spawnProjectile(pos: Vector2, rot: float, selection: int, amount: int = 1) -> void:
	for x in range(amount):
		var p = projectiles[selection].instantiate()
		
		p.position = pos
		p.rotation_degrees = rot
		
		owner.add_child(p)
		p.owner = owner

func _die() -> void:
	GameManager.PiecePickedUp(pieceIHold)
	super._die()
	pass
