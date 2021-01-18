# Carries damage data, including damage Modifiers
class_name Hit
extends Node

export var damage := 1

onready var modifiers := $Modifiers
