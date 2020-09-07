extends Area2D
class_name SelectableArea2D

signal selection_toggled(selected)

export var exclusive := true

var selected := false setget set_selected


func _input_event(viewport: Object, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_released("select"):
		exclusive = not exclusive
		selected = false
		exclusive = not Input.is_action_pressed("multiple_selection")
		set_selected(not selected)


func set_selected(select: bool) -> void:
	if select:
		_make_exclusive()
		add_to_group("selected")
	else:
		remove_from_group("selected")
	selected = select
	emit_signal("selection_toggled", selected)


func _make_exclusive() -> void:
	if not exclusive:
		return
	for selection_area in get_tree().get_nodes_in_group("selected"):
		selection_area.selected = false
