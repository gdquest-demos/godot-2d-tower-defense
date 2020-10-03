extends BasicTower

onready var _upgrades_container := $Upgrades
onready var _upgrade_panel := $UpgradePanel


func _ready() -> void:
	setup_upgrades()


func setup_upgrades() -> void:
	for upgrade in _upgrades_container.get_children():
		upgrade = upgrade as Upgrade
		upgrade.weapon = _weapon


func _on_SelectableArea2D_selection_changed(selected) -> void:
	._on_SelectableArea2D_selection_changed(selected)

	_upgrade_panel.visible = selected


func _on_UpgradePanel_upgrade_requested(upgrade_index: int) -> void:
	if _upgrades_container.get_child_count() < upgrade_index + 1:
		return
	_upgrades_container.get_child(upgrade_index).upgrade()
