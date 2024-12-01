extends Enemy
class_name Boss

var jeffery: Jeffery

@export var pieceIHold : String

@export var projectiles: Array[PackedScene]

var gameProgress: int

func _ready() -> void:
	
	jeffery = GameManager.jeffery
	
	#match(randi_range(0, 2)):
		#0:
			#pieceIHold = "d"
		#1:
			#pieceIHold = "c"
		#2:
			#pieceIHold = "f"
	
	super._ready()
	pass

func MakeHealthbar():
	GameManager.BossHealthbarSetup(self)

func spawnProjectile(pos: Vector2, rot: float, selection: int, amount: int = 1) -> void:
	for x in range(amount):
		var p = projectiles[selection].instantiate()
		
		p.position = pos
		p.rotation_degrees = rot
		
		GameManager.projectileOwner.add_child(p)
		p.owner = GameManager.projectileOwner

func _die() -> void:
	GameManager.BossDied()
	GameManager.PiecePickedUp(pieceIHold)
	SoundManager.PlayLoop("SecurityAlert", 0, -15.0, ".mp3")
	GameManager.Colortint.StartAnim()
	super._die()
	pass
