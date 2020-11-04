class_name BasicTower
extends Node2D

signal sold(price, place)

export var cost := 100

onready var _weapon := $Weapon2D
onready var _sell_button := $SellButton
onready var _range_preview := $RangePreview

func _ready() -> void:
	_range_preview.radius = _weapon.sight_range
	_range_preview.show_range()


func _on_SelectableArea2D_selection_changed(selected) -> void:
	_sell_button.visible = selected


func _on_SellButton_pressed() -> void:
	emit_signal("sold", cost * 0.5, position)
	queue_free()


func _on_SelectableArea2D_mouse_entered() -> void:
	_range_preview.radius = _weapon.sight_range
	_range_preview.show_range()


func _on_SelectableArea2D_mouse_exited() -> void:
	_range_preview.hide_range()
