extends Node2D

const PLACEBLE_CELLS_ID := 0

export var tower_placement_offset := Vector2(32, 64)

onready var _grid := $Grid

var _current_tower: Node2D


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	_snap_tower_to_grid()


func _input(event: InputEvent) -> void:
	if event.is_action_released("tower_placement"):
		set_process(false)
		_grid.visible = false


func add_new_tower(tower_scene: PackedScene) -> void:
	var tower_instance := tower_scene.instance() as Node2D
	add_child(tower_instance)

	_current_tower = tower_instance

	set_process(true)
	_grid.visible = true


func _snap_tower_to_grid() -> void:
	var cell: Vector2 = _grid.world_to_map(get_global_mouse_position())
	if not cell in _grid.get_used_cells_by_id(PLACEBLE_CELLS_ID):
		return
	_current_tower.global_position = _grid.map_to_world(cell)
	_current_tower.global_position += tower_placement_offset
