extends Upgrade


func _apply_upgrade() -> void:
	weapon.cooldown = max(0.0, weapon.cooldown - value)
