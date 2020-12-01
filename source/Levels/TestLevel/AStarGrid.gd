# Calculates a set of walkable positions between the _start_point and the _goal_point
extends TileMap

# The ID of the tile in the Tileset used to draw walkable cells
const WALKABLE_CELLS_ID := 1

onready var _start_point := $StartPosition2D
onready var _goal_point := $GoalPosition2D
onready var _astar := AStar2D.new()

onready var _walkable_cells: PoolVector2Array = get_used_cells_by_id(WALKABLE_CELLS_ID)


func update_walkable_cells() -> void:
	_walkable_cells = get_used_cells_by_id(WALKABLE_CELLS_ID)


func get_walkable_path() -> PoolVector2Array:
	var walkable_path := PoolVector2Array()

	var astar_path = _get_astar_path()
	for cell in astar_path:
		var point := map_to_world(cell)
		walkable_path.append(to_global(point))
	return walkable_path


func _get_astar_path() -> PoolVector2Array:
	var astar_path: PoolVector2Array

	_create_astar_points()

	_astar.set_point_position(0, world_to_map(_start_point.position))
	_astar.set_point_position(_astar.get_point_count() - 1, world_to_map(_goal_point.position))

	_connect_neighbor_cells()

	# Creates a walkable path from the _start_point to the _goal_point
	astar_path = _astar.get_point_path(0, _astar.get_point_count() - 1)
	return astar_path


func _create_astar_points() -> void:
	var start_to_goal_distance: float = _start_point.position.distance_to(_goal_point.position)

	# Sets cells ID by iteration order and their respective weight
	var cell_id := 0
	for cell in _walkable_cells:
		var weight := 1.0
		weight += map_to_world(cell).distance_to(_goal_point.position) / start_to_goal_distance
		_astar.add_point(cell_id, cell, weight)
		cell_id += 1


func _connect_neighbor_cells():
	# Turn the _walkable_cells in an Array in order to find its elements indices
	var walkable_cells_array := Array(_walkable_cells)

	for point in _astar.get_points():
		var cell = _astar.get_point_position(point)
		var neighbor_cells := Array(
			[
				cell + Vector2.UP,
				cell + Vector2.RIGHT,
				cell + Vector2.DOWN,
				cell + Vector2.LEFT,
			]
		)
		for neighbor_cell in neighbor_cells:
			if not neighbor_cell in _walkable_cells:
				continue
			var neighbor_cell_id := walkable_cells_array.find(neighbor_cell)
			if not point == neighbor_cell_id:
				_astar.connect_points(point, neighbor_cell_id)
