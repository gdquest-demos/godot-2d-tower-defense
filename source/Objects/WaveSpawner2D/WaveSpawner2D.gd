# Spawns enemy waves.
class_name WaveSpawner2D
extends Position2D

signal spawned(spawn)

export var spawn_scene: PackedScene


func spawn() -> Node2D:
	var spawning: Node2D = spawn_scene.instance()

	add_child(spawning)
	spawning.set_as_toplevel(true)
	spawning.global_position = global_position

	emit_signal("spawned", spawning)
	return spawning
