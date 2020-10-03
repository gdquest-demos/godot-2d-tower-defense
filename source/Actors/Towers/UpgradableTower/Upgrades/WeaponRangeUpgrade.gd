extends Upgrade


func _apply_upgrade() -> void:
	weapon.sight_range += value
