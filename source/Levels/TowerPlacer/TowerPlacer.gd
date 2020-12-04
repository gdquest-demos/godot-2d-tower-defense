# Allows the player to interactively place a tower on the game grid.
# Keeps track of cells that are free and those that are occupied.
extends Node2D

# The ID of the tiles where we can place a tower.
const EMPTY_CELL_ID := 4

onready var _grid := $Grid
onready var _visual_grid := $VisualGrid

var _current_cell := Vector2.ZERO
var _current_tower: Tower


func _ready() -> void:
	set_process(false)
	set_process_input(false)


func _process(_delta: float) -> void:
	_snap_tower_to_grid()


func _input(event: InputEvent) -> void:
	if event.is_action_released("tower_placement"):
		_place_tower()


func setup(tower_shop: UITowerShop) -> void:
	tower_shop.connect("tower_purchased", self, "add_new_tower")


# TODO: move player gold management?
# Gold should change when a tower is bought or sold
func add_new_tower(tower_scene: PackedScene) -> void:
	var tower: Tower = tower_scene.instance()
	if Player.gold - tower.cost < 0:
		tower.queue_free()
		return
	Player.gold -= tower.cost

	add_child(tower)
	_current_tower = tower

	set_process(true)
	set_process_input(true)
	_visual_grid.visible = true


func set_cell_unplaceable(cell: Vector2) -> void:
	_grid.set_cellv(cell, -1)


func set_cell_placeable(cell: Vector2) -> void:
	_grid.set_cellv(cell, EMPTY_CELL_ID)


func is_cell_placeable(cell: Vector2) -> bool:
	return _grid.get_cellv(cell) == EMPTY_CELL_ID


func _place_tower() -> void:
	if not is_cell_placeable(_current_cell):
		Player.gold += _current_tower.cost
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
	if not is_cell_placeable(_current_cell):
		_current_tower.modulate = Color(1, 0.375, 0.375)
	else:
		_current_tower.modulate = Color.white
	_current_tower.global_position = _grid.map_to_world(_current_cell)


func _on_Tower_sold(price: int, place: Vector2) -> void:
	Player.gold += price
	set_cell_placeable(_grid.world_to_map(place))
