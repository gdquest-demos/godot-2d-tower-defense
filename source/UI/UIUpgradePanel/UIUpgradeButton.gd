class_name UpgradeButton
extends Button


var upgrade: Upgrade setget set_upgrade


func set_upgrade(new_upgrade: Upgrade) -> void:
	upgrade = new_upgrade
	upgrade.connect("applied", self, "_on_Upgrade_applied")
	_update()


func get_upgrade_cost() -> int:
	return upgrade.cost


func apply_upgrade() -> void:
	upgrade.apply()


func _update() -> void:
	text = "%s: %sg" % [upgrade.text, upgrade.cost]
	hint_tooltip = upgrade.description


func _on_Upgrade_applied(_cost: int) -> void:
	_update()
