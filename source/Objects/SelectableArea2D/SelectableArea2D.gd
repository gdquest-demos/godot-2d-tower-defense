# Communicates selection states at object level.
class_name SelectableArea2D
extends Area2D

signal selection_changed(selected)

const SELECTION_GROUP := "selected"

export var exclusive := true
export var select_action := "select"
var selected := false setget set_selected


func _input_event(viewport: Object, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed(select_action):
		self.selected = not selected


func set_selected(select: bool) -> void:
	selected = select
	if exclusive and selected:
		for selectable_area in get_tree().get_nodes_in_group(SELECTION_GROUP):
			selectable_area.selected = false
	if selected:
		add_to_group(SELECTION_GROUP)
	else:
		remove_from_group(SELECTION_GROUP)
	emit_signal("selection_changed", selected)
