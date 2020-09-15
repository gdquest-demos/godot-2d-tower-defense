extends Node2D

signal wave_finished

export var tower_placement_offset := Vector2(32, 64)

onready var _grid := $Grid
onready var _towers_container := $Towers
onready var _astar_grid := $AStarGrid
onready var _enemies_container := $Enemies

onready var _total_enemies := _enemies_container.get_child_count()
onready var _enemies_at_goal_point := 0

var _current_tower: Node2D


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	_snap_tower_to_grid()


func _input(event: InputEvent) -> void:
	if event.is_action_released("tower_placement"):
		set_process(false)
		_grid.visible = false


func start():
	# TODO: spawn enemies with Wave from Wave System
	for enemy in _enemies_container.get_children():
		enemy.connect("movement_finished", self, "_on_Enemy_movement_finished")
	_start_enemies_movement()


func add_new_tower(tower_scene: PackedScene) -> void:
	var tower_instance := tower_scene.instance() as Node2D
	_towers_container.add_child(tower_instance)
	tower_instance.global_position = global_position
	
	_current_tower = tower_instance
	
	set_process(true)
	_grid.visible = true


func _start_enemies_movement() -> void:
	for enemy in _enemies_container.get_children():
		enemy.movement_path = _astar_grid.get_walkable_path(enemy.global_position)
		enemy.move()


func _snap_tower_to_grid() -> void:
	var cell: Vector2 = _grid.world_to_map(get_global_mouse_position())
	_current_tower.global_position = _grid.map_to_world(cell)
	_current_tower.global_position += tower_placement_offset


func _on_Enemy_movement_finished() -> void:
	_enemies_at_goal_point += 1
	if _enemies_at_goal_point >= _total_enemies:
		for enemy in _enemies_container.get_children():
			enemy.queue_free()
		emit_signal("wave_finished")
