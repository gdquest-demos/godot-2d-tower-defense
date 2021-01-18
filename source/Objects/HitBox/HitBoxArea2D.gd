# Represents a Hit dealt from the attacker perspective
class_name HitBox2D
extends Area2D

enum Teams { Player, Enemy }
export (Teams) var team := Teams.Player

export var hit_scene: PackedScene
export var can_hit_multiple := false


func apply_hit(hurt_box: HurtBox2D) -> void:
	if team == hurt_box.team:
		return
	hurt_box.get_hurt(hit_scene.instance())
	set_deferred("monitoring", can_hit_multiple) 


func _on_area_entered(area: Area2D) -> void:
	apply_hit(area)
