class_name Weapon2D
extends Node2D

signal fired()

export var bullet_scene: PackedScene
# Range of the weapon in pixels.
export var fire_range := 128.0 setget set_fire_range
# Cooldown in seconds to fire again
export var fire_cooldown := 1.0

onready var _bullet_spawn_position := $BulletSpawnPosition2D
onready var _cooldown_timer := $CooldownTimer
onready var _range_area := $RangeArea2D
onready var _animation_player := $AnimationPlayer
onready var _range_shape: CircleShape2D = $RangeArea2D/CollisionShape2D.shape
onready var _range_preview := $RangePreview


func _ready() -> void:
	set_fire_range(fire_range)
	show_range()


func _physics_process(_delta: float) -> void:
	if not _cooldown_timer.is_stopped():
		return

	var targets: Array = _range_area.get_overlapping_areas()
	if targets.empty():
		return

	var target: Node2D = targets[0]
	shoot_at(target.global_position)


func set_fire_range(new_range: float) -> void:
	fire_range = new_range
	if not is_inside_tree():
		yield(self, "ready")
	_range_shape.radius = fire_range


func shoot_at(target_position: Vector2) -> void:
	look_at(target_position)
	_animation_player.play("shoot")

	var bullet = bullet_scene.instance()
	add_child(bullet)
	bullet.global_position = _bullet_spawn_position.global_position
	bullet.fly_to(target_position)

	_cooldown_timer.start(fire_cooldown)
	emit_signal("fired")


func show_range() -> void:
	_range_preview.radius = fire_range
	_range_preview.appear()


func hide_range() -> void:
	_range_preview.disappear()
