extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_node("../../Raven")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	var random_archer = "archer" + str((randi() % 8) + 1) + "_idle"
	sprite.play(random_archer)


	
func _physics_process(delta: float) -> void:
	self.velocity.y += gravity * delta
	var distance = self.global_position.x - player.global_position.x
	#if distance > 50                                                       :
		#look_at(player.position)
	
	move_and_slide()
