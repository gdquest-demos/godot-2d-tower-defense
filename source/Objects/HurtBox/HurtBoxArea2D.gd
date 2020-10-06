# Represents a Hit dealt from the target perspective
class_name HurtBox2D
extends Area2D

signal hit_landed(hit)

enum Teams { Player, Enemy }
export (Teams) var team := Teams.Player


func get_hurt(hit: Hit) -> void:
	emit_signal("hit_landed", hit)
