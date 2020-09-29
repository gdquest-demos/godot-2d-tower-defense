extends Upgrade


func upgrade() -> void:
	.upgrade()
	_upgradable.sight_range += value
