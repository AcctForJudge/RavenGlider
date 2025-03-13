extends CharacterBody2D

@export var max_speed = 500
@export var jump = -300
@export var acceleration = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	
func _physics_process(delta: float) -> void:
	self.velocity.y += gravity * delta
	if Input.is_action_just_pressed("Fly"):
		self.velocity.y = jump
	self.velocity.x = min(self.velocity.x + acceleration * delta, max_speed)
	move_and_slide()
