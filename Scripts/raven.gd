extends CharacterBody2D

@export var speed = 300
@export var jump = -300

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	self.velocity.y += gravity * delta
	move_and_slide()
