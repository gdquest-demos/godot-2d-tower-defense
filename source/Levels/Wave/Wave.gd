class_name Wave
extends Node2D

signal starting
signal started
signal finished

export var enemy_time_interval := 0.5


func start() -> void:
	emit_signal("starting")
	for enemy in get_children():
		enemy.connect("tree_exited", self, "_on_Enemy_tree_exited")
		enemy.connect("movement_finished", self, "_on_Enemy_movement_finished", [enemy])
		enemy.move()
		yield(enemy, "moved")
		yield(get_tree().create_timer(enemy_time_interval), "timeout")
	emit_signal("started")


func is_wave_finished() -> bool:
	return get_child_count() < 1


func setup_enemy_movement_path(enemy: BasicEnemy, movement_path: PoolVector2Array) -> void:
	enemy.movement_path = movement_path


func _on_Enemy_tree_exited() -> void:
	if is_wave_finished():
		emit_signal("finished")


func _on_Enemy_movement_finished(enemy: BasicEnemy) -> void:
	enemy.queue_free()
