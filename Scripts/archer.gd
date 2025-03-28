extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_node("../../Raven")
@onready var state_chart:StateChart = $StateChart

 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var random_number

var arrows = []
var arrow_speed = 400



func _ready() -> void:
	random_number = str((randi() % 8) + 1)
	var random_archer = "archer" + random_number + "_idle"
	sprite.play(random_archer)

	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		self.velocity.y += gravity * delta
	sprite.flip_h = player.global_position.x > self.global_position.x
	
	#print(can_attack)
	move_and_slide()

func shoot_arrow():
	var new_arrow:PackedScene = load("res://Scenes/arrow.tscn")
	var arrow:RigidBody2D = new_arrow.instantiate()
	var distance:Vector2 = player.global_position - $Marker2D.global_position
	
	if self.sprite.flip_h:
		$Marker2D.position.x = -25.333
		arrow.rotation = PI / 2 - atan(distance.y / distance.x)
	else:
		arrow.rotation = PI / 2 - atan(distance.y / distance.x)

		
	arrows.append(arrow)
	$Marker2D.call_deferred("add_child", arrow)
	var dirn = distance.normalized()
	if distance.length() > 30:
		arrow.linear_velocity = dirn * arrow_speed * 1.5
	else:
		arrow.linear_velocity = dirn * arrow_speed
	
	#print(arrows.size())
	if arrows.size() > 10:
		var a = arrows.pop_front()
		if a:
			a.queue_free()

	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Raven":
		state_chart.send_event("Player Entered")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Raven":
		state_chart.send_event("Player Exited")


func _on_attack_state_entered() -> void:
	var random_archer = "archer" + random_number + "_shoot"
	sprite.play(random_archer)
	



func _on_animated_sprite_2d_frame_changed() -> void:
	if sprite.animation.ends_with("shoot") and sprite.frame == 8:
		shoot_arrow()
