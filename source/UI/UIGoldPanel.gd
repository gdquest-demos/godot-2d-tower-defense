extends Control


onready var _label: Label = $Label

var player: Player setget set_player

func set_player(new_player: Player) -> void:
	player = new_player
	player.connect("gold_changed", self, "_update_gold_amount")
	_update_gold_amount(player.gold)


func _update_gold_amount(new_amount: int) -> void:
	_label.text = "Gold: %s" % new_amount
