extends Node

@export var amount : int = 5
@export var soundPlayers: Array[AudioStreamPlayer]
@export var currentPlayer: int = 0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for x in range(amount):
		var audio = AudioStreamPlayer.new()
		add_child(audio)
		audio.owner = self
		soundPlayers.append(audio)

func PlaySound(Name: String) -> void:
	soundPlayers[currentPlayer].stream = load("res://Sounds/" + Name + ".wav")
	soundPlayers[currentPlayer].play()
	currentPlayer += 1
	if (currentPlayer >= soundPlayers.size()) :
		currentPlayer = 0
	pass
