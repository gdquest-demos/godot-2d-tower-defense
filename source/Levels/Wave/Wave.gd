class_name Wave
extends Node2D

signal starting
signal started
signal finished

# The time interval between each BasicEnemy first movement, used to
# create a gap between enemies by delaying the start of their movement
export var enemy_time_interval := 0.5


func _ready() -> void:
	enemy_time_interval = max(0.1, enemy_time_interval)


func start() -> void:
	emit_signal("starting")
	setup_enemies()
	move_enemies()


func setup_enemies() -> void:
	for enemy in get_children():
		enemy.move_delay = enemy_time_interval
		enemy.move_delay += enemy.get_index() * enemy_time_interval
		enemy.connect("tree_exited", self, "_on_Enemy_tree_exited")
		enemy.connect("movement_finished", self, "_on_Enemy_movement_finished", [enemy])


func move_enemies() -> void:
	for enemy in get_children():
		enemy.move()
	emit_signal("started")


func is_wave_finished() -> bool:
	return get_child_count() < 1


func set_enemy_movement_path(enemy: BasicEnemy, movement_path: PoolVector2Array) -> void:
	enemy.movement_path = movement_path


func _on_Enemy_tree_exited() -> void:
	if is_wave_finished():
		emit_signal("finished")


func _on_Enemy_movement_finished(enemy: BasicEnemy) -> void:
	enemy.queue_free()
