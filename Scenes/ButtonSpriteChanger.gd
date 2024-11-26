extends TextureButton

@export var normal : Texture
@export var NonHover : Texture

func _ready() -> void:
	texture_normal = NonHover

func _process(delta: float) -> void:
	if (is_hovered()) :
		texture_normal = normal
	else:
		texture_normal = NonHover
		
