# Manages damage data, including damage Modifier
class_name Hit
extends Node

export var damage := 1

onready var modifiers := $Modifiers.get_children()
