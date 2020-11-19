class_name Upgrade
extends Node

signal upgraded

export var cost := 100
export var value := 10.0
export (float, EASE) var cost_curve := 1.0

var weapon: Weapon


func upgrade() -> void:
	if Player.current_gold - cost < 0:
		return
	_apply_upgrade()
	Player.current_gold -= cost
	cost *= cost_curve
	emit_signal("upgraded")


func _apply_upgrade() -> void:
	pass
