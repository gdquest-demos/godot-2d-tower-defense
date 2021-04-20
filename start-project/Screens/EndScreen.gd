extends Control

export var player_score := 0

onready var _label := $Panel/Label

func _ready() -> void:
	_label.text = _label.text % player_score
