# Communicates selection states at object level.

class_name SelectableArea2D
extends Area2D

signal selection_changed(selected)

var selected := false setget set_selected


func set_selected(select: bool) -> void:
	selected = select
	emit_signal("selection_changed", selected)
