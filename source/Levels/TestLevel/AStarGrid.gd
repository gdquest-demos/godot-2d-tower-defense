extends TileMap

const WALKABLE_CELLS_ID := 1

export var position_offset := Vector2(32, 64)

onready var _start_point: Vector2 = world_to_map($StartPosition2D.global_position)
onready var _goal_point: Vector2 = world_to_map($GoalPosition2D.global_position)
onready var _astar := AStar2D.new()


func get_walkable_path(from_point: Vector2) -> PoolVector2Array:
	var walkable_path: PoolVector2Array
	var walkable_cells: PoolVector2Array = get_used_cells_by_id(WALKABLE_CELLS_ID)

	var astar_path = _get_astar_path(walkable_cells)
	for cell in astar_path:
		var point := map_to_world(cell)
		point += position_offset
		walkable_path.append(to_global(point))
	return walkable_path


func _get_astar_path(walkable_cells: PoolVector2Array) -> PoolVector2Array:
	var astar_path: PoolVector2Array
	var start_to_goal_distance := _start_point.distance_to(_goal_point)

	var cell_id := 0
	for cell in walkable_cells:
		var weight := 1.0
		weight += cell.distance_to(_goal_point) / start_to_goal_distance
		_astar.add_point(cell_id, cell, weight)
		cell_id += 1
	_astar.set_point_position(0, _start_point)
	_astar.set_point_position(_astar.get_point_count() - 1, _goal_point)

	var walkable_cells_array := Array(walkable_cells)
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
			if not neighbor_cell in walkable_cells:
				continue
			var neighbor_cell_id := walkable_cells_array.find(neighbor_cell)
			if not point == neighbor_cell_id:
				_astar.connect_points(point, neighbor_cell_id)
	astar_path = _astar.get_point_path(0, _astar.get_point_count() - 1)
	return astar_path
