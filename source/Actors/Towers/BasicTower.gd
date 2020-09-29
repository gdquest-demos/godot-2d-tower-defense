class_name BasicTower
extends Node2D

onready var _label := $Label
onready var _weapon := $Weapon2D


func _on_SelectableArea2D_selection_toggled(selected: bool) -> void:
	_label.visible = selected
