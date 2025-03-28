extends RigidBody2D

func _ready() -> void:
	#print(self.get_parent())
	pass
	
func _physics_process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	if body.name not in ["Archer", "Arrow"]:
		queue_free()
	#print(body)
