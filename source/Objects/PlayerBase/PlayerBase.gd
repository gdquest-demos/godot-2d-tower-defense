# The Player's main building.
extends Node2D

signal destroyed

export var max_health := 10
var health := max_health setget set_health

onready var _anim_player := $AnimationPlayer
onready var _interface := $Interface
onready var _health_bar := $Interface/HealthBar


func _ready() -> void:
	health = max_health
	_health_bar.setup(health, max_health)


func set_health(value: int) -> void:
	health = int(clamp(value, 0, max_health))
	_health_bar.set_current_amount(health)

	if health < 1:
		_destroy()


func _on_HurtBoxArea2D_hit_landed(damage: int) -> void:
	set_health(health - damage)


func _destroy() -> void:
	emit_signal("destroyed")
	_anim_player.play("Death")


func _on_SelectableArea2D_selection_changed(selected: bool) -> void:
	if selected:
		_interface.appear()
	else:
		_interface.disappear()
