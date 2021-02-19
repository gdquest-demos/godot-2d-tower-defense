# Represents a Hit dealt from the attacker perspective
class_name HitBoxArea2D
extends Area2D

enum Teams { PLAYER, ENEMY }
export (Teams) var team := Teams.PLAYER

export var damage := 1
export var can_hit_multiple := false


func apply_hit(hurt_box: HurtBoxArea2D) -> void:
	if team == hurt_box.team:
		return
	hurt_box.get_hurt(damage)
	set_deferred("monitoring", can_hit_multiple) 


func _on_area_entered(area: Area2D) -> void:
	apply_hit(area)
