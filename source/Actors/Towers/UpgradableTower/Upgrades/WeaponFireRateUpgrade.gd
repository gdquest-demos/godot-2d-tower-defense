extends Upgrade


func _apply_upgrade() -> void:
	# The maximum allowed fire rate is of 20 bullets per second.
	weapon.cooldown = max(0.05, weapon.cooldown - value)
