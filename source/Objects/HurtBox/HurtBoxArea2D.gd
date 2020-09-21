class_name HurtBox2D
extends Area2D

signal damaged(damage)

enum Teams {Player, Enemy}
export(Teams) var team := Teams.Player

export var weakness_hit: Resource

func get_hurt(hit: Hit) -> void:
	emit_signal("damaged", hit.damage)
