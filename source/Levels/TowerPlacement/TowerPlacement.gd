extends Node2D

# The ID of _grid cells that BasicTower can be placed on
const PLACEBLE_CELLS_ID := 0

onready var _grid := $Grid
onready var _tower_placement_offset: Vector2 = _grid.cell_size

var _current_tower: BasicTower


func _ready() -> void:
	_tower_placement_offset.x *= 0.5
	set_process(false)


func _process(delta: float) -> void:
	_snap_tower_to_grid()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tower_placement") and is_processing():
		get_tree().set_input_as_handled()
	if event.is_action_released("tower_placement"):
		_place_tower()


func add_new_tower(tower_scene: PackedScene) -> void:
	var tower_instance := tower_scene.instance() as Node2D
	if Player.current_gold - tower_instance.cost < 0:
		tower_instance.queue_free()
		return
	Player.current_gold -= tower_instance.cost

	add_child(tower_instance)

	_current_tower = tower_instance

	set_process(true)
	_grid.visible = true


func set_cell_unplaceable(cell: Vector2) -> void:
	_grid.set_cellv(cell, -1)


func _place_tower() -> void:
	var cell: Vector2 = _grid.world_to_map(get_global_mouse_position())
	if not cell in _grid.get_used_cells_by_id(PLACEBLE_CELLS_ID):
		Player.current_gold += _current_tower.cost
		_current_tower.queue_free()
	else:
		set_cell_unplaceable(cell)
	set_process(false)
	_grid.visible = false


func _snap_tower_to_grid() -> void:
	var cell: Vector2 = _grid.world_to_map(get_global_mouse_position())
	if not cell in _grid.get_used_cells_by_id(PLACEBLE_CELLS_ID):
		_current_tower.modulate = Color(1, 0.375, 0.375)
	else:
		_current_tower.modulate = Color.white
	_current_tower.global_position = _grid.map_to_world(cell)
	_current_tower.global_position += _tower_placement_offset
