extends TextureButton

@export var normal : Texture
@export var NonHover : Texture

func _ready() -> void:
	texture_normal = NonHover

func _process(delta: float) -> void:
	if (is_hovered()) :
		if (texture_normal == NonHover) :
			SoundManager.PlaySound("BulletHit")
		texture_normal = normal
	else:
		texture_normal = NonHover
		
func _on_pressed() -> void:
	SoundManager.PlaySound("GrappleHit")
