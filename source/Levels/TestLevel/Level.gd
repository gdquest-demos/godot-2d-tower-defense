# Controls Wave's flow and TowerPlacement
extends Node2D

signal finished
signal wave_finished
signal base_died

export var current_event := 0
var _wave: Wave

onready var _towers_placement := $TowerPlacement
onready var _astar_grid := $AStarGrid
onready var _wave_spawner := $WaveSpawner2D
onready var _events_player := $EventsPlayer


func _ready() -> void:
	setup_tower_placeable_cells()


func start() -> void:
	play_next_event()


func finish() -> void:
	emit_signal("finished")


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


func spawn_wave() -> void:
	_wave = yield(_wave_spawner.spawn(), "completed")
	_wave.connect("finished", self, "_on_Wave_finished")
	setup_wave_walk_path()
	_wave.start()


func play_event(event_index := current_event) -> void:
	var events_list: Array = _events_player.get_animation_list()
	var animation_count := events_list.size()
	if event_index >= animation_count:
		return
	_events_player.play(events_list[event_index])


func play_next_event() -> void:
	play_event(current_event)
	current_event += 1


func _on_Wave_finished() -> void:
	if current_event >= _events_player.get_animation_list().size():
		finish()
		return
	emit_signal("wave_finished")


func _on_PlayerBase_tree_exited() -> void:
	emit_signal("base_died")
