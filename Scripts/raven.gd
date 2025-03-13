extends CharacterBody2D

@export var speed = 0.3
@export var jump = -300

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	self.velocity.y += gravity * delta
	if Input.is_action_just_pressed("Fly"):
		self.velocity.y = jump
	self.velocity.x += speed 
	move_and_slide()
