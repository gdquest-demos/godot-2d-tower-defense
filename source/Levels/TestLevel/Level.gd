extends Node2D

signal wave_finished

export var next_wave_scene: PackedScene = preload("res://Levels/TestLevel/Waves/Wave1.tscn")

onready var _towers_placement := $TowerPlacement
onready var _astar_grid := $AStarGrid
onready var _wave := $Wave
onready var _wave_position_offset: Vector2 = _wave.position

var _current_wave := 0

func _ready() -> void:
	_wave.connect("finished", self, "_on_Wave_finished")


func start():
	for enemy in _wave.get_children():
		var movement_path = _astar_grid.get_walkable_path(enemy.global_position)
		_wave.setup_enemy_movement_path(enemy, movement_path)
	_wave.start()


func place_new_tower(new_tower_scene: PackedScene) -> void:
	_towers_placement.add_new_tower(new_tower_scene)


func _on_Wave_finished() -> void:
	_spawn_next_wave()
	emit_signal("wave_finished")


func _spawn_next_wave() -> void:
	var wave_index := _wave.get_index()
	_wave.queue_free()
	
	var new_wave := next_wave_scene.instance()
	add_child(new_wave)
	move_child(new_wave, wave_index)
	new_wave.position += _wave_position_offset
	_wave = new_wave
	
	new_wave.connect("finished", self, "_on_Wave_finished")
