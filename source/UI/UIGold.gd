extends Control


onready var _amount_label: Label = $AmountLabel

var player: Player

func setup() -> void:
	player.connect("gold_changed", self, "_update_gold_amount")
	_update_gold_amount(player.gold)


func _update_gold_amount(new_amount: int) -> void:
	_amount_label.text = str(new_amount)
