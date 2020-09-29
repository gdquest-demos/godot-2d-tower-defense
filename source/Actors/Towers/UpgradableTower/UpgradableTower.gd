extends BasicTower

onready var _upgrades_container := $Upgrades
onready var _upgrade_panel := $UpgradePanel

func _on_SelectableArea2D_selection_toggled(selected: bool) -> void:
	._on_SelectableArea2D_selection_toggled(selected)

	_upgrade_panel.visible = selected


func _on_UpgradePanel_upgrade_requested(upgrade_index: int) -> void:
	if _upgrades_container.get_child_count() < upgrade_index + 1:
		return
	_upgrades_container.get_child(upgrade_index).upgrade()
