extends Area2D

enum Teams {Player, Enemy}
export(Teams) var team := Teams.Player

export var hit: Resource 

func apply_hit(hurt_box: HurtBox2D) -> void:
	if team == hurt_box.team:
		return
	hurt_box.get_hurt(hit as Hit)
