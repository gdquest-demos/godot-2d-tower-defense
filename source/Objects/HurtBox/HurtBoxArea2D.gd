# Represents a Hit dealt from the target perspective
class_name HurtBox2D
extends Area2D

signal hit_landed(damage)

enum Teams { Player, Enemy }
export (Teams) var team := Teams.Player

export var armor := 0


func get_hurt(damage: int) -> void:
	emit_signal("hit_landed", damage - armor)
