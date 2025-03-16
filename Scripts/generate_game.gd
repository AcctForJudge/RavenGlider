extends Node2D

#chatgpt help lol
@export var chunk_scenes: Array[PackedScene] # Assign chunk scenes in the editor
var npcs =[]
var spawned_chunks = []

var chunk_size = 512 # 32 tiles, 16 pixels width, 32 * 16 = 512
var player # Reference to player node

func _ready():
	player = get_node("../Raven") # Adjust path if needed
	_spawn_initial_chunks()

func _process(_delta):
	if player.position.x > spawned_chunks[-1].position.x - chunk_size:
		_spawn_chunk()

func _spawn_initial_chunks():
	var first_chunk = chunk_scenes[0].instantiate()
	first_chunk.position = Vector2.ZERO
	spawned_chunks.append(first_chunk)
	add_child(first_chunk)
	_spawn_chunk()
	_spawn_chunk()

func _spawn_chunk():
	if chunk_scenes.is_empty():
		return

	var chunk_scene = chunk_scenes.pick_random()
	var new_chunk = chunk_scene.instantiate()

	if spawned_chunks.is_empty():
		new_chunk.position = Vector2.ZERO
	else:
		var last_chunk = spawned_chunks[-1]
		new_chunk.position = last_chunk.get_node("Marker2D").global_position + Vector2( chunk_size / 2, 0)

	spawned_chunks.append(new_chunk)
	add_child(new_chunk)
	
	_spawn_npcs()

	# Remove old chunks
	if spawned_chunks.size() > 5:
		var old_chunk = spawned_chunks.pop_front()
		old_chunk.queue_free()
	
func _spawn_npcs():
	var random_npcs = randi_range(1,3) * 2
	for i in range(random_npcs):
		var npc:PackedScene = load("res://Scenes/archer.tscn")
		var new_npc = npc.instantiate()
		npcs.append(new_npc)
		var x = randi_range(-250, -50)
		new_npc.position = spawned_chunks[-1].get_node("Marker2D").global_position + Vector2(x, -900)
		add_child(new_npc)
	
	if npcs.size() > 30:
		var old_npc = npcs.pop_front()
		old_npc.queue_free()
	
