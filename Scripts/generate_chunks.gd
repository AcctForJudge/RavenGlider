extends Node2D

#chatgpt help lol
@export var chunk_scenes: Array[PackedScene] # Assign chunk scenes in the editor
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
	for i in range(3): # Start with 3 chunks
		_spawn_chunk()

func _spawn_chunk():
	if chunk_scenes.is_empty():
		return

	var chunk_scene = chunk_scenes[randi() % chunk_scenes.size()]
	var new_chunk = chunk_scene.instantiate()

	if spawned_chunks.is_empty():
		new_chunk.position = Vector2.ZERO
	else:
		var last_chunk = spawned_chunks[-1]
		new_chunk.position = last_chunk.get_node("Marker2D").global_position

	spawned_chunks.append(new_chunk)
	add_child(new_chunk)

	# Remove old chunks
	if spawned_chunks.size() > 5:
		var old_chunk = spawned_chunks.pop_front()
		old_chunk.queue_free()
