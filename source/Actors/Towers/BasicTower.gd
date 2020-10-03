class_name BasicTower
extends Node2D

export var cost := 100

onready var _label := $Label
onready var _weapon := $Weapon2D


func _on_SelectableArea2D_selection_changed(selected) -> void:
	_label.visible = selected
