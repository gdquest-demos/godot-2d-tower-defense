extends Area2D

signal hit_landed

enum Teams {Player, Enemy}
export(Teams) var team := Teams.Player

export var hit: Resource 


func apply_hit(hurt_box: HurtBox2D) -> void:
	if team == hurt_box.team:
		return
	hurt_box.get_hurt(hit as Hit)
	emit_signal("hit_landed")


func _on_area_entered(area: Area2D) -> void:
	apply_hit(area)
