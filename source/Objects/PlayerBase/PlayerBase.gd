# The Player's main building.
extends Node2D


onready var _health := $Health
onready var _health_bar := $HealthBar
onready var _anim_player := $AnimationPlayer


func _ready() -> void:
	_health_bar.max_value = _health.max_amount
	_health_bar.value = _health.amount


func _on_HurtBoxArea2D_hit_landed(hit: Hit) -> void:
	_health.amount -= hit.damage


func _on_Health_changed(current_amount: int) -> void:
	_health_bar.value = current_amount


func _on_Health_max_changed(new_max: int) -> void:
	_health_bar.max_value = new_max


func _on_Health_depleted() -> void:
	_anim_player.play("Death")
