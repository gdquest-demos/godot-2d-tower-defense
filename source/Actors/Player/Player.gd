class_name Player
extends Node

signal gold_changed(gold_amount)

export var gold := 100 setget set_gold


func set_gold(new_amount: int) -> void:
	gold = max(0, new_amount)
	emit_signal("gold_changed", gold)
