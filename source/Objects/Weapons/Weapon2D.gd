class_name Weapon
extends Position2D

var target: Node2D

export var bullet_scene: PackedScene

onready var sight_shape: CircleShape2D = $RangeArea2D/CollisionShape2D.shape

onready var _bullet_spawner := $BulletSpawner2D
onready var _cooldown_timer := $CooldownTimer
onready var _range_area := $RangeArea2D
onready var _animation_player := $AnimationPlayer


func _shoot() -> void:
	_update_target()
	if not target:
		return
	if not _cooldown_timer.is_stopped():
		return
	_cooldown_timer.start()

	look_at(target.global_position)
	_animation_player.play("shoot")

	_bullet_spawner.spawn_scene = bullet_scene
	var bullet: Bullet = yield(_bullet_spawner.spawn(), "completed")
	bullet.fly_to(target.global_position)


func _update_target() -> void:
	var overlapping_areas: Array = _range_area.get_overlapping_areas()
	if overlapping_areas.size() > 0:
		target = overlapping_areas[0]
	else:
		_clear_target()


func _clear_target() -> void:
	target = null
	_cooldown_timer.stop()


func _on_RangeArea2D_area_entered(area: Area2D) -> void:
	target = area
	target.connect("tree_exiting", self, "_clear_target")
	_shoot()


func _on_RangeArea2D_area_exited(area: Area2D) -> void:
	if target and target.is_connected("tree_exiting", self, "_clear_target"):
		target.disconnect("tree_exiting", self, "_clear_target")
	_update_target()


func _on_CooldownTimer_timeout() -> void:
	_shoot()
