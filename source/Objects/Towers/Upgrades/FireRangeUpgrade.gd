extends Upgrade


func _apply() -> void:
	weapon.fire_range += value
	weapon.show_range()
