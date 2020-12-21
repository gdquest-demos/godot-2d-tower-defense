# Controls Wave's flow and TowerPlacement
extends Node2D

signal finished
signal wave_finished
signal base_destroyed

const TOWER_PLACEABLE_CELLS_ID := 3
const ENEMY_WALK_PATH_CELLS_ID := 2

export var current_event := 0
var _wave: Wave

onready var tower_placer := $TowerPlacer
onready var _tilemap := $TileMap
onready var _astar_grid := $AStarGrid
onready var _wave_spawner := $WaveSpawner2D
onready var _events_player := $EventsPlayer
onready var _path_preview := $PathPreview


func _ready() -> void:
	_setup()
	_show_walkable_path()


func start() -> void:
	_path_preview.fade_out()
	play_next_event()


func finish() -> void:
	emit_signal("finished")


func _setup() -> void:
	tower_placer.setup_available_cells(_tilemap.get_used_cells_by_id(TOWER_PLACEABLE_CELLS_ID))
	_astar_grid.start_point = $StartPosition2D.position
	_astar_grid.goal_point = $GoalPosition2D.position
	_astar_grid.walkable_cells = _tilemap.get_used_cells_by_id(ENEMY_WALK_PATH_CELLS_ID)


func _show_walkable_path(walking_path := _astar_grid.get_walkable_path()) -> void:
	_path_preview.clear_points()
	_path_preview.points = walking_path
	_path_preview.fade_in()


func _setup_wave_path() -> void:
	var movement_path: PoolVector2Array = _astar_grid.get_walkable_path()
	for enemy in _wave.get_children():
		enemy.position += movement_path[0]
		_wave.set_movement_path(movement_path)


func spawn_wave() -> void:
	_wave = yield(_wave_spawner.spawn(), "completed")
	_wave.connect("finished", self, "_on_Wave_finished")
	_setup_wave_path()
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
	_show_walkable_path()


func _on_PlayerBase_destroyed():
	emit_signal("base_destroyed")
