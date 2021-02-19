# Represents a Hit dealt from the target perspective
class_name HurtBoxArea2D
extends Area2D

signal hit_landed(damage)

enum Teams { PLAYER, ENEMY }
export (Teams) var team := Teams.PLAYER

export var armor := 0


func get_hurt(damage: int) -> void:
	var final_damage := damage - armor
	emit_signal("hit_landed", final_damage)
