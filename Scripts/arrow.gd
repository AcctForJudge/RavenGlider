extends RigidBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player: CharacterBody2D = get_node("../../../../Raven")



func _physics_process(delta: float) -> void:
	if linear_velocity.y < 0:
		add_constant_torque(1)
	if rotation == PI / 2:
		add_constant_torque(-1)

func _on_body_entered(body: Node) -> void:
	if body.name not in ["Archer", "Arrow"]:
		queue_free()
	#print(body)
