# Allows the player to interactively place a tower on the game grid.
# Keeps track of free and occupied cells.
class_name TowerPlacer
extends TileMap

signal tower_placed(tower)

# The ID of the tiles where players can place a tower.
const AVAILABLE_CELL_ID := 0
const INVALID_CELL_ID := 1

onready var _visual_grid := $VisualGrid

var _current_cell := Vector2.ZERO
var _current_tower: Tower


func _ready() -> void:
	set_process_unhandled_input(false)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_snap_tower_to_grid()
	if event.is_action_pressed("tower_placement"):
		_place_tower()


func setup_available_cells(cells_array: PoolVector2Array) -> void:
	for cell in cells_array:
		set_cell_placeable(cell)


func add_new_tower(tower: Tower) -> void:
	if _current_tower:
		_current_tower.queue_free()

	add_child(tower)
	_current_tower = tower

	set_process_unhandled_input(true)
	_visual_grid.visible = true

	_snap_tower_to_grid()


func set_cell_unplaceable(cell: Vector2) -> void:
	set_cellv(cell, INVALID_CELL_ID)


func set_cell_placeable(cell: Vector2) -> void:
	set_cellv(cell, AVAILABLE_CELL_ID)


func is_cell_placeable(cell: Vector2) -> bool:
	return get_cellv(cell) == AVAILABLE_CELL_ID


func _place_tower() -> void:
	set_process_unhandled_input(false)
	_visual_grid.visible = false

	if not is_cell_placeable(_current_cell):
		_current_tower.queue_free()
		_current_tower = null
		return
	set_cell_unplaceable(_current_cell)

	emit_signal("tower_placed", _current_tower)
	_current_tower.connect("sold", self, "_on_Tower_sold")
	_current_tower = null


func _snap_tower_to_grid() -> void:
	_current_cell = world_to_map(get_global_mouse_position())
	_current_tower.global_position = map_to_world(_current_cell)
	if not is_cell_placeable(_current_cell):
		_current_tower.modulate = Color(1, 0.375, 0.375)
	else:
		_current_tower.modulate = Color.white


func _on_Tower_sold(_price: int, place: Vector2) -> void:
	set_cell_placeable(world_to_map(place))
