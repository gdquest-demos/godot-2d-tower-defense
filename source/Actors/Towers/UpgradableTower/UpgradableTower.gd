extends Tower

onready var _upgrades_container := $Upgrades


func _ready() -> void:
	setup_upgrades()
	find_node("TowerNameLabel").text = name.capitalize()


func setup_upgrades() -> void:
	for upgrade in _upgrades_container.get_children():
		upgrade = upgrade as Upgrade
		upgrade.weapon = _weapon
		upgrade.connect("upgraded", self, "_on_Upgrade_upgraded")


func _on_UpgradePanel_upgrade_requested(upgrade_index: int) -> void:
	if _upgrades_container.get_child_count() < upgrade_index + 1:
		return
	_upgrades_container.get_child(upgrade_index).upgrade()


func _on_Upgrade_upgraded() -> void:
	_range_preview.radius = _weapon.sight_range
	_range_preview.appear()
