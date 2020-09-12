extends TileMap

const WALKABLE_CELLS_ID := 1

export var points_offset := Vector2(32, 64)

onready var start_point: Vector2 = $StartPosition2D.global_position
onready var goal_point: Vector2 = $GoalPosition2D.global_position
onready var _astar := AStar2D.new()

func get_best_path(from_point: Vector2) -> PoolVector2Array:
	var best_path: PoolVector2Array
	var walkable_cells: PoolVector2Array = get_used_cells_by_id(WALKABLE_CELLS_ID)
	
	var astar_path = _get_astar_path(walkable_cells)
	for cell in astar_path:
		var point := map_to_world(cell)
		point += points_offset
		best_path.append(to_global(point))
	return best_path


func _get_astar_path(walkable_cells: PoolVector2Array) -> PoolVector2Array:
	var astar_path: PoolVector2Array
	_astar.clear()
	
	var point_id := 0
	for cell in walkable_cells:
		_astar.add_point(point_id, cell)
		point_id += 1
	
	_astar.add_point(0, world_to_map(start_point))
	_astar.add_point(_astar.get_point_count() -1, world_to_map(goal_point))
	
	for point in _astar.get_point_count() -1:
		_astar.connect_points(point, point + 1)
	
	astar_path = _astar.get_point_path(0, _astar.get_point_count() -1)
	return astar_path
