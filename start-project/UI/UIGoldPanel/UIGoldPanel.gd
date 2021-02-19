extends Control


onready var _amount_label: Label = $AmountLabel

func update_gold_amount(new_amount: int) -> void:
	_amount_label.text = "Gold: %s" % new_amount
