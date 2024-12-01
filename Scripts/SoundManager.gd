extends Node

var playersAmount : int = 20
var soundPlayers: Array[AudioStreamPlayer]

var currentPlayer: int = 0


#Loop Channels for looping sounds I don't want overriden
# 0 - Background Music
# 1 - Sword Audio (ex: Chainsaw everything)
# 2 - Gun Audio (ex: Charge Weaponing)
# 3 - Extra
# 4 - Extra2
var loopAmount : int = 5
var soundLoops: Array[AudioStreamPlayer]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for x in range(playersAmount):
		var audio = AudioStreamPlayer.new()
		add_child(audio)
		audio.owner = self
		soundPlayers.append(audio)
	
	for x in range(loopAmount):
		var audio = AudioStreamPlayer.new()
		add_child(audio)
		audio.owner = self
		soundLoops.append(audio)


func PlaySound(Name: String, Volume: float = 0.0, extension: String = ".wav") -> void:
	currentPlayer += 1
	if (currentPlayer >= soundPlayers.size()) :
		currentPlayer = 0
	PlaySoundChannel(Name, currentPlayer, Volume, extension)


func PlaySoundChannel(Name: String, Channel: int, Volume: float = 0.0, extension: String = ".wav") -> void:
	if (Channel >= playersAmount) :
		Channel = 0
	if (!ResourceLoader.exists("res://Sounds/" + Name + extension)) :
		return
	soundPlayers[Channel].stream = load("res://Sounds/" + Name + extension)
	soundPlayers[Channel].volume_db = Volume
	soundPlayers[Channel].play()


func PlayLoop(Name: String, Channel: int, Volume: float = 0.0, extension: String = ".wav"):
	if (Channel >= loopAmount) :
		Channel = loopAmount - 1
	if (!ResourceLoader.exists("res://Sounds/" + Name + extension)) :
		return
	soundLoops[Channel].stream = load("res://Sounds/" + Name + extension)
	soundLoops[Channel].volume_db = Volume
	soundLoops[Channel].play()

func StopLoop(Channel: int):
	if (Channel >= loopAmount) :
		Channel = loopAmount - 1
	soundLoops[Channel].stop()
