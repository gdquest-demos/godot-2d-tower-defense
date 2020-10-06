class_name BasicEnemy
extends PathFollow2D

signal movement_started
signal movement_finished

export var idle_duration := 0.5
export var move_delay := 0.5
export var speed := 64.0 setget set_speed
export var move_length := 1.0

onready var _tween := $MovementTween
onready var _timer := $IdleTimer
onready var _health := $Health
onready var _anim := $AnimationPlayer
onready var _sprite_anim := $Sprite/AnimationPlayer


func set_speed(new_speed: float) -> void:
	speed = new_speed
	if not is_inside_tree():
		yield(self, "ready")
	if _tween.is_active():
		_walk_path()


func move() -> void:
	yield(get_tree().create_timer(move_delay), "timeout")
	emit_signal("movement_started")
	_walk_path()


func die() -> void:
	_tween.stop_all()
	_anim.play("die")


func _walk_path() -> void:
	if _tween.is_active():
		_tween.stop(self, "unit_offset")
	
	var duration := move_length / speed
	_tween.interpolate_property(self, "unit_offset", unit_offset, 1.0, duration)
	_tween.start()


func _on_Health_depleted() -> void:
	die()


func _on_HurtBoxArea2D_hit_landed(hit: Hit) -> void:
	_health.amount -= hit.damage
	# Hits are added as children in order to process their Modifiers 
	add_child(hit)
	for modifier in hit.modifiers:
		modifier.target = self
	_walk_path()


func _on_MovementTween_tween_completed(object: Object, key: NodePath) -> void:
	if idle_duration > 0.0:
		_timer.start(idle_duration)

	if unit_offset >= 1.0:
		emit_signal("movement_finished")
		die()


func _on_IdleTimer_timeout() -> void:
	_walk_path()
