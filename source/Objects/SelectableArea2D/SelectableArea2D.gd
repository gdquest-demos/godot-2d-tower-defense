# Communicates selection states at individual level.
class_name SelectableArea2D
extends Area2D

signal selection_changed(selected)

export var select_action := "select"

var selected := false setget set_selected

var _is_mouse_on := false


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed(select_action):
		return
	if not _is_mouse_on:
		set_selected(false)


func _input_event(viewport: Object, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed(select_action):
		self.selected = not selected
		get_tree().set_input_as_handled()


func set_selected(select: bool) -> void:
	selected = select
	emit_signal("selection_changed", selected)


func _on_mouse_entered() -> void:
	_is_mouse_on = true


func _on_mouse_exited() -> void:
	_is_mouse_on = false
