extends Node2D

onready var label := $Label


func _on_SelectableArea2D_selection_toggled(selected: bool) -> void:
	label.visible = selected
