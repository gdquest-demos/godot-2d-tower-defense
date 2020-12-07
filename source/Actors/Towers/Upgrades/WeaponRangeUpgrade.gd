extends Upgrade


func _apply_upgrade() -> void:
	weapon.fire_range += value
