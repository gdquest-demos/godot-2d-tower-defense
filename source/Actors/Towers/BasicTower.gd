class_name BasicTower
extends Node2D

signal sold(price, place)

export var cost := 100

onready var _label := $Label
onready var _weapon := $Weapon2D
onready var _sell_button := $SellButton


func _on_SelectableArea2D_selection_changed(selected) -> void:
	_label.visible = selected
	_sell_button.visible = selected


func _on_SellButton_pressed() -> void:
	emit_signal("sold", cost * 0.5, position)
	queue_free()
