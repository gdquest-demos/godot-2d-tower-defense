class_name Upgrade
extends Node


export var cost := 100
export var value := 10.0
export (float, EASE) var cost_curve := 1.0

export var upgradable_path: NodePath

onready var _upgradable := get_node(upgradable_path)

func upgrade() -> void:
	# Todo check if player has enough resources to upgrade
	cost *= cost_curve
