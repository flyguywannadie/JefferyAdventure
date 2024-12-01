extends Node2D

@export var CutsceneCameraTrack : CamTrack
@export var EndCameraTrack : CamTrack

@export var cutsceneAnimator : AnimationPlayer

func StartCutscene():
	GameManager.GetGameCamera().changeTrack(CutsceneCameraTrack, true)
	GameManager.StartCutscene()
	cutsceneAnimator.play("StartCutscene")

func PlayMusic():
	SoundManager.PlayLoop("BossMusic", 0, 0.0)

func EndCutscene():
	GameManager.GetGameCamera().changeTrack(EndCameraTrack, true)
	GameManager.EndCutscene()
