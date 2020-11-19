extends Upgrade


func _apply_upgrade() -> void:
	var bullet: Bullet = weapon.bullet_scene.instance()
	bullet.speed += value

	weapon.bullet_scene.pack(bullet)
