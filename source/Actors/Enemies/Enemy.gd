class_name Enemy
extends PathFollow2D

signal health_changed(new_amount)
signal died

# Movement speed in pixels per second.
export var speed := 64.0
# Amount of gold earned upon killing this enemy.
export var gold_value := 50

export var max_health := 15
var health := max_health setget set_health

onready var _health_bar := $HealthBar
onready var _anim_player := $AnimationPlayer
onready var _sprite_anim_player := $Sprite/AnimationPlayer


func _ready() -> void:
	_health_bar.setup(health, max_health)
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	if unit_offset >= 1.0:
		set_physics_process(false)
		disappear()
		return
	offset += speed * delta


func move() -> void:
	set_physics_process(true)


func disappear() -> void:
	_anim_player.play("disappear")


func die() -> void:
	emit_signal("died")
	# TODO: move gold management?
	Player.gold += gold_value
	disappear()


func set_health(value: int) -> void:
	health = int(clamp(value, 0, max_health))
	emit_signal("health_changed", health)
	
	if health < 1:
		die()


func _on_HurtBoxArea2D_hit_landed(hit: Hit) -> void:
	set_health(health - hit.damage)
	# Hits are added as children in order to process their Modifiers
	add_child(hit)
	for modifier in hit.modifiers.get_children():
		modifier.target = self
