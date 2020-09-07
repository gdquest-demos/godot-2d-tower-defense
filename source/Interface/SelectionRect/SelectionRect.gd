extends ColorRect
class_name SelectionRect

var click_position := Vector2.ZERO


func _ready() -> void:
	rect_size = Vector2.ZERO
	set_process(false)


func _process(delta: float) -> void:
	expand_to_mouse()


func _unhandled_input(event) -> void:
	if event.is_action("select"):
		if event.is_pressed():
			click_position = get_global_mouse_position()
		else:
			deselect()
			select()
			reset_rect()
		set_process(event.is_pressed())


func expand_to_mouse() -> void:
	var mouse_position := get_global_mouse_position()
	
	var min_point = Vector2.ZERO
	min_point.x = min(mouse_position.x, click_position.x)
	min_point.y = min(mouse_position.y, click_position.y)
	set_begin(min_point)
	
	var max_point := Vector2.ZERO
	max_point.x = max(mouse_position.x, click_position.x)
	max_point.y = max(mouse_position.y, click_position.y)
	set_end(max_point)


func select() -> void:
	var selectable_area: SelectableArea2D
	
	for node in get_tree().get_nodes_in_group("selectable"):
		selectable_area = node.get_node("SelectableArea2D") as SelectableArea2D
		if get_global_rect().has_point(selectable_area.global_position):
			selectable_area.exclusive = false
			selectable_area.selected = true


func deselect() -> void:
	for selection_area in get_tree().get_nodes_in_group("selected"):
		selection_area.exclusive = true
		selection_area.selected = false


func reset_rect() -> void:
	rect_size = Vector2.ZERO
