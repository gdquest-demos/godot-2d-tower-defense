class_name Weapon
extends Node2D

export var bullet_scene: PackedScene
# Range of the weapon in pixels.
export var fire_range := 200.0 setget set_fire_range
# Cooldown to fire again after shooting in seconds.
export var fire_cooldown := 1.0 setget set_fire_cooldown

onready var _bullet_spawn_position := $BulletSpawnPosition
onready var _cooldown_timer := $CooldownTimer
onready var _range_area := $RangeArea2D
onready var _range_shape: CircleShape2D = $RangeArea2D/CollisionShape2D.shape
onready var _animation_player := $AnimationPlayer


func _ready() -> void:
	# TODO: Replace with parameters and a setup function on the bullet?
	bullet_scene = bullet_scene.duplicate()


func _physics_process(_delta: float) -> void:
	if not _cooldown_timer.is_stopped():
		return

	var targets: Array = _range_area.get_overlapping_areas()
	if targets.empty():
		return

	var target: Node2D = targets[0]
	_shoot_at(target)


func set_fire_range(new_range: float) -> void:
	fire_range = new_range
	if not is_inside_tree():
		yield(self, "ready")
	_range_shape.radius = fire_range


func set_fire_cooldown(new_cooldown: float) -> void:
	fire_cooldown = new_cooldown
	if not is_inside_tree():
		yield(self, "ready")
	_cooldown_timer.wait_time = fire_cooldown


func _shoot_at(target: Node2D) -> void:
	_cooldown_timer.start(fire_cooldown)

	look_at(target.global_position)
	_animation_player.play("shoot")
	
	var bullet = bullet_scene.instance()
	add_child(bullet)
	bullet.global_position = _bullet_spawn_position.global_position
	bullet.fly_to(target.global_position)



