# The Player's main building.
extends Node2D

signal destroyed

export var max_health := 10
var health := max_health setget set_health

onready var _sprites := $Sprites
onready var _interface := $Interface
onready var _ui_health_bar := $Interface/HealthBar
onready var _health_bar := $HealthBar
onready var _hurt_box := $HurtBoxArea2D


func _ready() -> void:
	health = max_health

	# Share the Interface/HealthBar's values with the HealthBar
	# to keep them synced
	_ui_health_bar.share(_health_bar)

	_ui_health_bar.max_value = max_health
	_ui_health_bar.value = health


func set_health(value: int) -> void:
	health = clamp(value, 0, max_health)

	_ui_health_bar.value = health

	if health < 1:
		_destroy()


func _destroy() -> void:
	emit_signal("destroyed")
	_sprites.play("Explode")

	# Make a deferred call to prevent errors
	_hurt_box.set_deferred("monitorable", false)


func _on_HurtBoxArea2D_hit_landed(damage: int) -> void:
	set_health(health - damage)


func _on_SelectableArea2D_selection_changed(selected: bool) -> void:
	if selected:
		_interface.appear()
	else:
		_interface.disappear()
