class_name BasicTower
extends Node2D

signal sold(price, place)

export var cost := 100

onready var _range_preview := $RangePreview
onready var _weapon := $Weapon2D
onready var _anim_player := $AnimationPlayer
onready var _selection := $SelectableArea2D


func _ready() -> void:
	show_interface()


func show_interface() -> void:
	_range_preview.radius = _weapon.sight_range
	_range_preview.appear()
	_anim_player.play("appear")


func hide_interface() -> void:
	_range_preview.disappear()
	_anim_player.play("disappear")


func _on_SelectableArea2D_selection_changed(selected) -> void:
	if selected:
		show_interface()
		
	else:
		hide_interface()


func _on_SellButton_pressed() -> void:
	emit_signal("sold", cost * 0.5, position)
	queue_free()
