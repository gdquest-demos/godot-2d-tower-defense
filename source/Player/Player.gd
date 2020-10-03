extends Node

signal gold_changed(current_gold_amount)

export var current_gold := 100 setget set_gold

func set_gold(new_amount: int) -> void:
	current_gold = max(0, new_amount)
	emit_signal("gold_changed", current_gold)
