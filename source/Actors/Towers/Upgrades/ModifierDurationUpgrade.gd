extends Upgrade


func _apply_upgrade() -> void:
	var bullet: Bullet = weapon.bullet_scene.instance()
	for modifier in bullet.modifiers.get_children():
		modifier.duration += value
	weapon.bullet_scene.pack(bullet)
