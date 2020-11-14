class_name Weapon
extends Node2D

var target: Node2D

export var bullet_scene: PackedScene
export var sight_range := 200.0 setget set_sight_range
export var cooldown := 1.0

onready var _bullet_spawner := $BulletSpawner2D
onready var _cooldown_timer := $CooldownTimer
onready var _range_area := $RangeArea2D
onready var _range_shape: CircleShape2D = $RangeArea2D/CollisionShape2D.shape
onready var _animation_player := $AnimationPlayer


func _ready() -> void:
	self.sight_range = sight_range
	bullet_scene = bullet_scene.duplicate()


func set_sight_range(new_range: float) -> void:
	sight_range = new_range
	if not is_inside_tree():
		yield(self, "ready")
	_range_shape.radius = sight_range


func _shoot() -> void:
	_update_target()
	if not target:
		return
	if not _cooldown_timer.is_stopped():
		return
	_cooldown_timer.start(cooldown)

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


func _on_RangeArea2D_area_entered(area: Area2D) -> void:
	_shoot()


func _on_RangeArea2D_area_exited(area: Area2D) -> void:
	_shoot()


func _on_CooldownTimer_timeout() -> void:
	_shoot()
