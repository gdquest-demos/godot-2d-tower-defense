extends Position2D


var target: Node2D

onready var _bullet_spawner := $BulletSpawner2D
onready var _cooldown_timer := $CooldownTimer
onready var _range_area := $RangeArea2D
onready var _animation_player := $AnimationPlayer


func _shoot() -> void:
	if not target:
		return
	if not _cooldown_timer.is_stopped():
		return
	_cooldown_timer.start()
	
	look_at(target.global_position)
	_animation_player.play("shoot")
	var bullet: Bullet = _bullet_spawner.spawn()
	bullet.fly_to(target.global_position)


func _clear_target() -> void:
	target = null
	_cooldown_timer.stop()


func _on_RangeArea2D_area_entered(area: Area2D) -> void:
	target = area
	target.connect("tree_exiting", self, "_clear_target")
	_shoot()


func _on_RangeArea2D_area_exited(area: Area2D) -> void:
	yield(get_tree(), "physics_frame")
	if _range_area.get_overlapping_areas().size() > 0:
		target = _range_area.get_overlapping_areas()[0]
	else:
		_clear_target()


func _on_CooldownTimer_timeout() -> void:
	_shoot()
