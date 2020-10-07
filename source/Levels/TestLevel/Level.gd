# Controls Wave's flow and TowerPlacement
extends Node2D

signal wave_finished
signal base_died

export var next_wave_scene: PackedScene = preload("res://Levels/TestLevel/Waves/Wave1.tscn")

var _wave: Wave

onready var _towers_placement := $TowerPlacement
onready var _astar_grid := $AStarGrid


func _ready() -> void:
	setup_tower_placeable_cells()


func start():
	_spawn_next_wave()
	setup_wave_walk_path()

	_wave.start()


func setup_tower_placeable_cells() -> void:
	for cell in _astar_grid.get_used_cells_by_id(_astar_grid.WALKABLE_CELLS_ID):
		_towers_placement.set_cell_unplaceable(cell)


func place_new_tower(new_tower_scene: PackedScene) -> void:
	_towers_placement.add_new_tower(new_tower_scene)


func setup_wave_walk_path() -> void:
	var movement_path: PoolVector2Array = _astar_grid.get_walkable_path()
	for enemy in _wave.get_children():
		enemy.position += movement_path[0]
		_wave.set_movement_path(movement_path)


func _spawn_next_wave() -> void:
	if _wave:
		_wave.queue_free()

	var new_wave := next_wave_scene.instance()
	_wave = new_wave

	add_child(_wave)
	_wave.connect("finished", self, "_on_Wave_finished")


func _on_Wave_finished() -> void:
	emit_signal("wave_finished")


func _on_PlayerBase_tree_exited() -> void:
	emit_signal("base_died")
