# Controls Wave's flow and TowerPlacement
extends Node2D

signal finished
signal round_finished
signal base_destroyed
signal gold_earned(gold_amount)

const TOWER_PLACEABLE_CELLS_ID := 3
const ENEMY_WALK_PATH_CELLS_ID := 2

export(String, FILE, "*.tscn") var next_level_path

onready var tower_placer := $TowerPlacer
onready var _tilemap := $TileMap
onready var _astar_grid := $AStarGrid
onready var _wave_spawner := $WaveSpawner2D
onready var _events_player := $EventsPlayer
onready var _path_preview := $PathPreview
onready var _player_base := $GoalPoint/PlayerBase


func _ready() -> void:
	_setup()


func start() -> void:
	_path_preview.fade_out()
	_events_player.play_current_event()


func finish() -> void:
	if _player_base.health > 0:
		emit_signal("finished")


func spawn_wave() -> void:
	var wave = _wave_spawner.spawn()
	wave.connect("finished", self, "_on_Wave_finished")
	_setup_wave_path(wave)

	for enemy in wave.get_children():
		enemy.connect("died", self, "_on_Enemy_died")

	wave.start()


func start_round() -> void:
	if _events_player.current_event >= _events_player.get_animation_list().size():
		finish()
		return
	emit_signal("round_finished")


func _setup() -> void:
	tower_placer.setup_available_cells(_tilemap.get_used_cells_by_id(TOWER_PLACEABLE_CELLS_ID))
	_astar_grid.walkable_cells = _tilemap.get_used_cells_by_id(ENEMY_WALK_PATH_CELLS_ID)
	_astar_grid.start_point = $StartPoint.position
	_astar_grid.goal_point = $GoalPoint.position
	show_walkable_path()


func show_walkable_path(walking_path := _astar_grid.get_walkable_path()) -> void:
	_path_preview.clear_points()
	_path_preview.points = walking_path
	_path_preview.fade_in()


func _setup_wave_path(wave: Wave) -> void:
	wave.set_movement_path(_astar_grid.get_walkable_path())


func _on_Wave_finished() -> void:
	start_round()


func _on_PlayerBase_destroyed():
	emit_signal("base_destroyed")


func _on_Enemy_died(gold_earned: int) -> void:
	emit_signal("gold_earned", gold_earned)


func _on_round_finished() -> void:
	start()
