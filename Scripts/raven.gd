extends CharacterBody2D

@export var max_speed = 500
@export var min_speed = 50
@export var jump = -100
@export var acceleration = 5
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var gravity = 700 #980 default

func _ready() -> void:
	self.velocity.x = max_speed / 5
	
func _physics_process(delta: float) -> void:
	self.velocity.y += gravity * delta
	var pressed = false
	if Input.is_action_pressed("Fly"):
		self.velocity.y = jump
		pressed = true
	
	if pressed:
		sprite.play("fly_input")
	else:
		sprite.play("fly_no_input")
	self.velocity.x += acceleration * delta
	if self.velocity.x > max_speed:
		self.velocity.x = max_speed
	if self.velocity.x < min_speed:
		self.velocity.x = min_speed
	move_and_slide()
	
