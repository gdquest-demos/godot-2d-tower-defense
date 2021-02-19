extends Node2D


onready var _anim_player := $AnimationPlayer

func play(animation: String) -> void:
	_anim_player.play(animation)
