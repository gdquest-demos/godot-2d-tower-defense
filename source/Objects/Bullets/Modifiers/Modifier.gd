class_name Modifier
extends Node2D

export var duration := 1.0
export var strength := 1.0

var target: BasicEnemy

onready var _duration_timer := $DurationTimer
onready var _animation_player := $AnimationPlayer


func _ready() -> void:
	_duration_timer.wait_time = duration
	_animation_player.play("start")


func apply_effect() -> void:
	pass


func remove_effect() -> void:
	pass


func _on_DurationTimer_timeout() -> void:
	_animation_player.play("finish")
