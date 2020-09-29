extends Upgrade


func upgrade() -> void:
	.upgrade()
	var bullet: Bullet = _upgradable.bullet_scene.instance()
	bullet.speed += value
	
	_upgradable.bullet_scene.pack(bullet)
