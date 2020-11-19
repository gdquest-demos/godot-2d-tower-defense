extends Node2D

# The ID of _grid cells that BasicTower can be placed on
const PLACEABLE_CELLS_ID := 4

onready var _grid := $Grid
onready var _visual_grid := $VisualGrid

var _current_cell := Vector2.ZERO
var _current_tower: BasicTower


func _ready() -> void:
	set_process(false)
	set_process_input(false)


func _process(delta: float) -> void:
	_snap_tower_to_grid()


func _input(event: InputEvent) -> void:
	if event.is_action_released("tower_placement"):
		_place_tower()


func add_new_tower(tower_scene: PackedScene) -> void:
	var tower: BasicTower = tower_scene.instance()
	if Player.current_gold - tower.cost < 0:
		tower.queue_free()
		return
	Player.current_gold -= tower.cost

	add_child(tower)
	_current_tower = tower

	set_process(true)
	set_process_input(true)
	_visual_grid.visible = true


func set_cell_unplaceable(cell: Vector2) -> void:
	_grid.set_cellv(cell, -1)


func set_cell_placeable(cell: Vector2) -> void:
	_grid.set_cellv(cell, PLACEABLE_CELLS_ID)


func is_cell_placeable(cell: Vector2) -> bool:
	return _grid.get_cellv(cell) == PLACEABLE_CELLS_ID


func _is_current_cell_placeable() -> bool:
	return is_cell_placeable(_current_cell)


func _place_tower() -> void:
	if not _is_current_cell_placeable():
		Player.current_gold += _current_tower.cost
		_current_tower.queue_free()
	else:
		set_cell_unplaceable(_current_cell)
		_current_tower.connect("sold", self, "_on_Tower_sold")
		_current_tower.hide_interface()

	set_process(false)
	set_process_input(false)
	_visual_grid.visible = false


func _snap_tower_to_grid() -> void:
	_current_cell = _grid.world_to_map(get_global_mouse_position())
	if not _is_current_cell_placeable():
		_current_tower.modulate = Color(1, 0.375, 0.375)
	else:
		_current_tower.modulate = Color.white
	_current_tower.global_position = _grid.map_to_world(_current_cell)


func _on_Tower_sold(price: int, place: Vector2) -> void:
	Player.current_gold += price
	set_cell_placeable(_grid.world_to_map(place))
