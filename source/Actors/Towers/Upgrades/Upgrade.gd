class_name Upgrade
extends Node

signal upgraded

# The upgrade's cost in gold.
export var cost := 100
# The amount to upgrade depending on the property. E.g. 10.0 on Weapon.fire_range 
export var value := 10.0
# How much, in percentage, the cost increases every time the upgrade is applied.
export (float, EASE) var cost_curve := 1.0

var weapon: Weapon


func upgrade() -> void:
	#TODO: this function shouldn't be called if there's not enough gold.
	if Player.gold - cost < 0:
		return
	_apply_upgrade()
	Player.gold -= cost
	cost = int(cost * cost_curve)
	emit_signal("upgraded")


# Virtual function.
func _apply_upgrade() -> void:
	pass
