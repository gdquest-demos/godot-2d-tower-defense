# Communicates selection states at individual level.
class_name SelectableArea2D
extends Area2D

signal selection_changed(selected)

export var select_action := "select"

var selected := false setget set_selected


func _ready() -> void:
	set_process_unhandled_input(false)


func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed(select_action):
		set_selected(not selected)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(select_action):
		set_selected(false)
		set_process_unhandled_input(false)


func set_selected(select: bool) -> void:
	selected = select
	if selected:
		add_to_group("selected")
	else:
		remove_from_group("selected")
	emit_signal("selection_changed", selected)


func _on_mouse_entered() -> void:
	set_process_unhandled_input(false)


func _on_mouse_exited() -> void:
	set_process_unhandled_input(selected)
