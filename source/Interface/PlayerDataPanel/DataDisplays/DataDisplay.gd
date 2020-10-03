extends HBoxContainer


var data_name := "" setget set_data_name
var data_amount := 0.0 setget set_data_amount

onready var _name_label := $NameLabel
onready var _amount_label := $AmountLabel

func set_data_name(new_data_name: String) -> void:
	data_name = new_data_name
	_name_label.text = data_name


func set_data_amount(new_data_amount: float) -> void:
	data_amount = new_data_amount
	_amount_label.text = "%d" % new_data_amount
