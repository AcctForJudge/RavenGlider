extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_node("../../Raven")

 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var random_number

func _ready() -> void:
	random_number = str((randi() % 8) + 1)
	var random_archer = "archer" + random_number + "_idle"
	sprite.play(random_archer)

	
func _physics_process(delta: float) -> void:
	self.velocity.y += gravity * delta
	sprite.flip_h = player.global_position.x > self.global_position.x
		
	move_and_slide()
