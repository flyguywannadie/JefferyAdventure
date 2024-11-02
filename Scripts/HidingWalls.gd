extends TileMapLayer
class_name hidewalls

var fadeto : float = 1.0

func _ready() -> void:
	print(material)
	print(material.get("shader_parameter/fade"))

func _physics_process(delta: float) -> void:
	var test = sign(fadeto - material.get("shader_parameter/fade"))
	material.set("shader_parameter/fade", material.get("shader_parameter/fade") + (delta * test))


func _on_secret_thing_body_entered(body: Node2D) -> void:
	fadeto = 0.33


func _on_secret_thing_body_exited(body: Node2D) -> void:
	fadeto = 1.0
