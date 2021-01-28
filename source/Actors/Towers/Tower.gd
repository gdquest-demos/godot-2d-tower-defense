class_name Tower
extends Node2D

signal sold(price, place)

export var cost := 100

onready var _weapon := $Weapon2D
onready var _interface := $Interface
onready var _selection := $SelectableArea2D


func _ready() -> void:
	_selection.selected = true


func show_interface() -> void:
	_weapon.show_range()
	_interface.appear()


func hide_interface() -> void:
	_weapon.hide_range()
	_interface.disappear()


func _on_SelectableArea2D_selection_changed(selected) -> void:
	if selected:
		show_interface()
	else:
		hide_interface()


func _on_SellButton_pressed() -> void:
	emit_signal("sold", cost * 0.5, position)
	queue_free()
