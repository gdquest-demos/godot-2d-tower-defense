# Manages a resource used in game mechanics. Don't confuse with Resource.
# Used to represent Health, Energy...
extends Node

signal changed(current_amount)
signal max_changed(new_max)
signal depleted

export var max_amount := 10 setget set_max

onready var amount := max_amount setget set_amount


func set_max(new_max: int) -> void:
	max_amount = max(0, new_max)
	emit_signal("max_changed", max_amount)


func set_amount(new_amount: int) -> void:
	amount = clamp(new_amount, 0, max_amount)
	if amount < 1:
		emit_signal("depleted")
	emit_signal("changed", amount)
