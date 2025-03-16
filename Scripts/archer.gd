extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_node("../../Raven")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	var random_archer = "archer" + str((randi() % 8) + 1) + "_idle"
	sprite.play(random_archer)


	
func _physics_process(delta: float) -> void:
	self.velocity.y += gravity * delta
	sprite.flip_h = player.global_position.x > self.global_position.x
		
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body, " has entered me uwu")


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
