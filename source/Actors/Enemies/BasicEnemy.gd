class_name BasicEnemy
extends PathFollow2D

export var speed := 64.0
export var gold_amount := 50

onready var _health := $Health
onready var _health_bar := $HealthBar
onready var _anim := $AnimationPlayer
onready var _sprite_anim := $Sprite/AnimationPlayer


func _ready() -> void:
	_health_bar.value = _health.amount
	_health_bar.max_value = _health.max_amount
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
	_anim.play("disappear")


func apply_damage(damage: int) -> void:
	_health.amount -= damage


func die() -> void:
	Player.gold += gold_amount
	disappear()


func _on_HurtBoxArea2D_hit_landed(hit: Hit) -> void:
	apply_damage(hit.damage)
	# Hits are added as children in order to process their Modifiers 
	add_child(hit)
	for modifier in hit.modifiers.get_children():
		modifier.target = self


func _on_Health_changed(current_amount: int) -> void:
	if not is_inside_tree():
		yield(self, "ready")
	_health_bar.value = current_amount


func _on_Health_max_changed(new_max: int) -> void:
	if not is_inside_tree():
		yield(self, "ready")
	_health_bar.max_value = new_max


func _on_Health_depleted() -> void:
	die()
