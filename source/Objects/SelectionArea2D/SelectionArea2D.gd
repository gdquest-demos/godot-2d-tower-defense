# Selects and stores SelectableArea2Ds overlapping with its CollisionShape2D

class_name SelectionArea2D
extends Area2D

export var color: Color = Color("#44ffff88")

var is_active := false setget set_is_active

var _rectangle: Rect2 = Rect2(Vector2.ZERO, Vector2.ZERO) setget set_rectangle
var _selected := []

onready var _collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	self._rectangle.size = get_local_mouse_position() - _rectangle.position
	clear_selection()
	select()


func _unhandled_input(event) -> void:
	if event.is_action("select"):
		if event.is_pressed():
			self._rectangle.position = get_local_mouse_position() - global_position
		set_is_active(event.is_pressed())
		get_tree().set_input_as_handled()


func _draw() -> void:
	draw_rect(_rectangle, color)


func select() -> void:
	_selected = get_overlapping_areas()
	for area in _selected:
		area.selected = true


func clear_selection() -> void:
	for area in _selected:
		area.selected = false
	_selected.clear()


func set_rectangle(value: Rect2) -> void:
	_rectangle = value
	if not _collision_shape:
		yield(self, "ready")
	_collision_shape.position = _rectangle.position + _rectangle.size / 2.0
	_collision_shape.shape.extents = _rectangle.size / 2.0
	update()


func set_is_active(value: bool) -> void:
	is_active = value
	set_physics_process(is_active)
	monitoring = is_active
	visible = is_active
	if not is_active:
		_rectangle = Rect2(Vector2.ZERO, Vector2.ZERO)
