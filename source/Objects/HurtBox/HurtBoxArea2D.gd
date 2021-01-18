# Represents a Hit dealt from the target perspective
class_name HurtBox2D
extends Area2D

signal hit_landed(hit)

enum Teams { Player, Enemy }
export (Teams) var team := Teams.Player


func get_hurt(hit: Hit) -> void:
	# Hits are added as children in order to process their Modifiers
	add_child(hit)
	emit_signal("hit_landed", hit)
