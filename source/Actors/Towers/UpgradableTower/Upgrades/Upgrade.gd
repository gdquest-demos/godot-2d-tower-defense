class_name Upgrade
extends Node

signal upgraded

# The upgrade's cost in gold.
export var cost := 100
export var value := 10.0
export (float, EASE) var cost_curve := 1.0

var weapon: Weapon

# TODO: Simplify bullet to not have to unpack and repack the scene every time.
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
