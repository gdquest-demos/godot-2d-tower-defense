extends PanelContainer


onready var _data_displays_container := $MarginContainer/VBoxContainer/DataDisplays

func _ready() -> void:
	setup_gold_data()


func setup_gold_data() -> void:
	Player.connect("gold_changed", self, "_on_Player_gold_changed")
	Player.current_gold += 0


func _on_Player_gold_changed(new_gold_amount: int) -> void:
	_data_displays_container.find_node("Gold*").data_amount = new_gold_amount
