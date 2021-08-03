# Spawns enemy waves.
class_name WaveSpawner2D
extends Position2D

signal spawned(spawn)

export var spawn_scene: PackedScene


func spawn() -> Node2D:
	var spawn: Node2D = spawn_scene.instance()

	add_child(spawn)
	spawn.set_as_toplevel(true)
	spawn.global_position = global_position

	emit_signal("spawned", spawn)
	return spawn
