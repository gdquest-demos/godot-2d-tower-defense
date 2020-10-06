# Manages a resource used by an Actor. Don't confuse with Resource.
# Used to represent Health, Energy...
extends Node

signal changed(current_amount)
signal depleted

export var max_amount := 10

onready var amount := max_amount setget set_amount


func set_amount(new_amount: int) -> void:
	amount = new_amount
	amount = clamp(amount, 0, max_amount)
	if amount < 1:
		emit_signal("depleted")
	emit_signal("changed", amount)
