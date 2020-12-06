# Controls Wave's flow and TowerPlacement
extends Node2D

signal finished
signal wave_finished
signal base_died

export var current_event := 0
var _wave: Wave

onready var tower_placer := $TowerPlacer
onready var _astar_grid := $AStarGrid
onready var _wave_spawner := $WaveSpawner2D
onready var _events_player := $EventsPlayer
onready var _path_preview := $PathPreview
onready var _tilemap := $TileMap


func _ready() -> void:
	setup_tower_placeable_cells()
	setup_walkable_cells()
	show_walkable_path()


func start() -> void:
	_path_preview.fade_out()
	play_next_event()


func finish() -> void:
	emit_signal("finished")


# TODO: pass the data to tower_placer and let it do its thing.
func setup_tower_placeable_cells() -> void:
	for cell in _tilemap.get_used_cells():
		if _tilemap.get_cellv(cell) == tower_placer.EMPTY_CELL_ID:
			tower_placer.set_cell_placeable(cell)
		else:
			_towers_placement.set_cell_unplaceable(cell)


func setup_walkable_cells() -> void:
	_astar_grid.start_point = $StartPosition2D.position
	_astar_grid.goal_point = $GoalPosition2D.position
	_astar_grid.walkable_cells = _tilemap.get_used_cells_by_id(_astar_grid.WALKABLE_CELLS_ID)


func place_new_tower(new_tower_scene: PackedScene) -> void:
	_towers_placement.add_new_tower(new_tower_scene)


func show_walkable_path(walking_path := _astar_grid.get_walkable_path()) -> void:
	_path_preview.clear_points()
	_path_preview.points = walking_path
	_path_preview.fade_in()


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
	show_walkable_path()


func _on_PlayerBase_destroyed():
	emit_signal("base_died")
	pass # Replace with function body.
