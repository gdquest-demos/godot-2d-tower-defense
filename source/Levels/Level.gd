extends Node2D

export var tower_placement_offset := Vector2(32, 64)

onready var grid := $Grid
onready var towers_container := $Towers

var _current_tower: Node2D


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	_snap_tower_to_grid()


func _input(event: InputEvent) -> void:
	if event.is_action_released("tower_placement"):
		set_process(false)
		grid.visible = false


func add_new_tower(tower_scene: PackedScene) -> void:
	var tower_instance := tower_scene.instance() as Node2D
	towers_container.add_child(tower_instance)
	tower_instance.global_position = global_position
	
	_current_tower = tower_instance
	
	set_process(true)
	grid.visible = true


func _snap_tower_to_grid() -> void:
	var snapped_mouse_position: Vector2 = grid.world_to_map(get_global_mouse_position())
	_current_tower.global_position = grid.map_to_world(snapped_mouse_position)
	_current_tower.global_position += tower_placement_offset
