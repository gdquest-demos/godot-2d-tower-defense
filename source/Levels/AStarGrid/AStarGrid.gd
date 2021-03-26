# Calculates a set of walkable positions between the start_point and the goal_point
extends TileMap

const DIRECTIONS := [
	Vector2.UP,
	Vector2.LEFT,
	Vector2.RIGHT,
	Vector2.DOWN
]

export var start_point := Vector2.ZERO
export var goal_point := Vector2.ZERO
export var offset := Vector2(32, 32)

var walkable_cells: PoolVector2Array

var _astar := AStar2D.new()
var _start_id := 0
var _goal_id := 0


func get_walkable_path() -> PoolVector2Array:
	var walkable_path := PoolVector2Array()

	var astar_path = _get_astar_path()
	for cell in astar_path:
		var point := map_to_world(cell)
		walkable_path.append(to_global(point) + offset)
	return walkable_path


func _get_astar_path() -> PoolVector2Array:
	var astar_path: PoolVector2Array

	_create_astar_points()
	_connect_neighbor_cells()

	# Creates a walkable path from the start_point to the goal_point
	astar_path = _astar.get_point_path(_start_id, _goal_id)
	return astar_path


func _create_astar_points() -> void:
	# Sets cells ID by iteration order
	var cell_id := 0
	for cell in walkable_cells:
		_astar.add_point(cell_id, cell)

		# Store the start and goal point IDs
		if cell == world_to_map(start_point):
			_start_id = cell_id
		if cell == world_to_map(goal_point):
			_goal_id = cell_id

		cell_id += 1


func _connect_neighbor_cells():
	# Turn the walkable_cells in an Array to find its elements indices
	var walkable_cells_array := Array(walkable_cells)

	for point in _astar.get_points():
		var cell = _astar.get_point_position(point)
		for direction in DIRECTIONS:
			var neighbor_cell_id = walkable_cells_array.find(cell + direction)
			# Skip cells that weren't found 
			if neighbor_cell_id == -1:
				continue
			_astar.connect_points(point, neighbor_cell_id)
