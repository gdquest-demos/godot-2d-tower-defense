extends PanelContainer

signal upgrade_requested(upgrade_index)

#TODO: refactor
onready var _options := $MarginContainer/VBoxContainer/OptionsVBoxContainer


func _ready() -> void:
	for option in _options.get_children():
		var button: Button = option.get_node("UpgradeButton")
		button.connect("pressed", self, "_on_UpgradeButton_pressed", [option.get_index()])


func _on_UpgradeButton_pressed(option_index: int) -> void:
	emit_signal("upgrade_requested", option_index)
