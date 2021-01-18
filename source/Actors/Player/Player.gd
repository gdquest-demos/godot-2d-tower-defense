class_name Player
extends Node

signal gold_changed(gold_amount)

export var gold := 100 setget set_gold

onready var _initial_gold = gold


func set_gold(new_amount: int) -> void:
	gold = int(max(0, new_amount))
	emit_signal("gold_changed", gold)


func reset() -> void:
	set_gold(_initial_gold)
