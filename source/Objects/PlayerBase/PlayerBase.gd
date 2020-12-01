# The Player's main building.
extends Node2D

signal health_changed(new_amount)

export var max_health := 10
var health := max_health setget set_health

onready var _health_bar := $HealthBar
onready var _anim_player := $AnimationPlayer


func _ready() -> void:
	_health_bar.setup(health, max_health)


func set_health(value: int) -> void:
	health = int(clamp(value, 0, 10))
	emit_signal("health_changed", health)


func _on_HurtBoxArea2D_hit_landed(hit: Hit) -> void:
	set_health(health - hit.damage)


func _on_Health_depleted() -> void:
	_anim_player.play("Death")
