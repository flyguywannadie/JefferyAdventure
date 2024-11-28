extends TextureRect
class_name BossHealthbar

@export var bossITrack: Boss

func _ready() -> void:
	GameManager.bossHealthbar = self
	Hide()

func Appear() -> void:
	visible = true

func Hide() -> void:
	visible = false

func _physics_process(delta: float) -> void:
	if (bossITrack == null) :
		if (visible) :
			Hide()
		return
	material.set("shader_parameter/fill", float(bossITrack.health)/float(bossITrack.maxHealth))
