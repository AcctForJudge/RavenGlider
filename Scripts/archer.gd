extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	var random_archer = "archer" + str((randi() % 8) + 1) + "_idle"
	self.sprite.play(random_archer)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	
func _physics_process(delta: float) -> void:
	self.velocity.y += gravity * delta
	move_and_slide()
