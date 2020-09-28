extends Node


var tower_weapon: Weapon


func upgrade(upgrade_name: String) -> void:
	match upgrade_name:
		"weapon_range":
			tower_weapon.sight_shape.radius += 100.0
		"bullet_speed":
			var bullet_scene := tower_weapon.bullet_scene
			
			var bullet_instance := bullet_scene.instance()
			bullet_instance.speed += 500.0
			
			var new_bullet_scene := PackedScene.new()
			new_bullet_scene.pack(bullet_instance)
			
			tower_weapon.bullet_scene = new_bullet_scene
			bullet_instance.queue_free()


func _on_UpgradePanel_upgrade_requested(upgrade_name: String) -> void:
	upgrade(upgrade_name)
