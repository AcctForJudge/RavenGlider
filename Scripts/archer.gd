extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_node("../../Raven")
@onready var state_chart:StateChart = $StateChart
@onready var attack_timer: Timer = $StateChart/Root/Attack/AttackTimer
 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var random_number
var can_attack = false
var arrows = []

func _ready() -> void:
	random_number = str((randi() % 8) + 1)
	var random_archer = "archer" + random_number + "_idle"
	sprite.play(random_archer)

	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		self.velocity.y += gravity * delta
	sprite.flip_h = player.global_position.x > self.global_position.x
	move_and_slide()

func shoot_arrow():
	var new_arrow = load("res://Scenes/arrow.tscn")
	var arrow = new_arrow.instantiate()
	arrows.append(arrow)
	add_child(arrow)
	
	if arrows.size() > 2:
		var old = arrows.pop_front()
		old.queue_free()
		
	attack_timer.start()
	can_attack = false
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	state_chart.send_event("Player Entered")


func _on_area_2d_body_exited(body: Node2D) -> void:
	state_chart.send_event("Player Exited")


func _on_attack_state_entered() -> void:
	can_attack = true
	shoot_arrow()
	
	
func _on_attack_timer_timeout() -> void:
	can_attack = true
	shoot_arrow()
