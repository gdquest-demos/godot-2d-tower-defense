class_name Bullet
extends Node2D

export var speed := 500.0

onready var _tween := $Tween
onready var _hitbox := $HitBoxArea2D
onready var _anim_player := $AnimationPlayer


func fly_to(target_global_position: Vector2) -> void:
	var distance := global_position.distance_to(target_global_position)
	var duration := distance / speed

	_tween.interpolate_property(
		self, "global_position", global_position, target_global_position, duration
	)
	_tween.start()
	look_at(target_global_position)


func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	_anim_player.play("explode")
