class_name UIUpgradeButton
extends Button


func update_display(upgrade: Upgrade, player_gold: int) -> void:
	text = "%s: %sg" % [upgrade.display_name, upgrade.cost]
	hint_tooltip = upgrade.description
	disabled = player_gold < upgrade.cost
