extends Node2D

signal wave_finished

export var next_wave_scene: PackedScene = preload("res://Levels/TestLevel/Waves/Wave1.tscn")

onready var _towers_placement := $TowerPlacement
onready var _astar_grid := $AStarGrid

var _wave: Wave

var _current_wave := 0


func start():
	_spawn_next_wave()
	for enemy in _wave.get_children():
		var movement_path = _astar_grid.get_walkable_path(enemy.global_position)
		enemy.position += movement_path[0]
		_wave.setup_enemy_movement_path(enemy, movement_path)
	_wave.start()


func place_new_tower(new_tower_scene: PackedScene) -> void:
	_towers_placement.add_new_tower(new_tower_scene)


func _on_Wave_finished() -> void:
	emit_signal("wave_finished")


func _spawn_next_wave() -> void:
	if _wave:
		_wave.queue_free()
	
	var new_wave := next_wave_scene.instance()
	_wave = new_wave

	add_child(_wave)
	move_child(_wave, _towers_placement.get_index() + 1)
	_wave.connect("finished", self, "_on_Wave_finished")
