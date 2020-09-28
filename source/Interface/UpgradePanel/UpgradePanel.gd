extends PanelContainer

signal upgrade_requested(upgrade_name)


func _on_WeaponUpgradeButton_pressed() -> void:
	emit_signal("upgrade_requested", "weapon_range")


func _on_BulletSpeedUpgradeButton_pressed() -> void:
	emit_signal("upgrade_requested", "bullet_speed")
