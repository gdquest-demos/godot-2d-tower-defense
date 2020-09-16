class_name BasicEnemy
extends Node2D

signal movement_started
signal movement_finished
signal moved

export var speed := 64.0 setget set_speed
export var idle_duration := 0.5

var movement_path: PoolVector2Array = []

onready var _tween := $MovementTween
onready var _timer := $IdleTimer

func move() -> void:
	emit_signal("movement_started")
	
	for point in movement_path:
		_tween_to_next_point(point)
		yield(_tween, "tween_completed")
		_timer.start(idle_duration)
		yield(_timer, "timeout")
		movement_path.remove(0)
		emit_signal("moved")
	emit_signal("movement_finished")


func set_speed(new_speed: float) -> void:
	speed = new_speed
	if not is_inside_tree():
		return
	_tween.stop(self, "global_position")
	move()


func _tween_to_next_point(point: Vector2) -> void:
	var distance_to_point := global_position.distance_to(point)
	var duration := distance_to_point / speed
	
	_tween.interpolate_property(
		self,
		"global_position",
		global_position,
		point,
		duration
		)
	_tween.start()
