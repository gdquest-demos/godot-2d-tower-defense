class_name Upgrade
extends Node

signal applied(cost)


export var text := "Upgrade name"
export(String, MULTILINE) var description := "Upgrade description"
export var cost := 100
export(float, EASE) var cost_curve := 1.0
export var value := 100.0

var weapon: Weapon2D

func apply() -> void:
	_apply()
	cost = int(cost * cost_curve)
	emit_signal("applied", cost)


# Virtual method, override in children according to upgrade effect
func _apply() -> void:
	pass
