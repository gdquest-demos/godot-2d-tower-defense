class_name BasicEnemy
extends Node2D

signal movement_started
signal movement_finished

export var speed := 64.0 setget set_speed
export var idle_duration := 0.5
export var move_delay := 0.5

var movement_path: PoolVector2Array = []

onready var _tween := $MovementTween
onready var _timer := $IdleTimer
onready var _health := $Health
onready var _anim := $AnimationPlayer
onready var _sprite_anim := $Sprite/AnimationPlayer


func move() -> void:
	if movement_path.size() == 0:
		return

	_timer.start(move_delay)
	yield(_timer, "timeout")
	emit_signal("movement_started")

	for point in movement_path:
		_tween_to_next_point(point)
		yield(_tween, "tween_completed")

		if idle_duration > 0.0:
			_timer.start(idle_duration)
			yield(_timer, "timeout")

		movement_path.remove(0)

	emit_signal("movement_finished")


func die() -> void:
	_tween.stop_all()
	_anim.play("die")


func set_speed(new_speed: float) -> void:
	speed = new_speed
	if not is_inside_tree():
		yield(self, "ready")
	_tween.stop(self, "global_position")
	move()


func _tween_to_next_point(point: Vector2) -> void:
	var distance_to_point := global_position.distance_to(point)
	var duration := distance_to_point / speed

	_tween.interpolate_property(self, "global_position", global_position, point, duration)
	_tween.start()


func _on_Health_depleted() -> void:
	die()


func _on_HurtBoxArea2D_hit_landed(hit: Hit) -> void:
	_health.amount -= hit.damage
	add_child(hit)
	for modifier in hit.modifiers:
		modifier.target = self
