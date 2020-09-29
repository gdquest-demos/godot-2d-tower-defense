extends Area2D

signal hit_landed

enum Teams { Player, Enemy }
export (Teams) var team := Teams.Player

export var can_hit_multiple := false
export var hit_scene: PackedScene

var _can_hit := true


func apply_hit(hurt_box: HurtBox2D) -> void:
	if team == hurt_box.team:
		return
	if not _can_hit:
		return
	_can_hit = can_hit_multiple
	hurt_box.get_hurt(hit_scene.instance())
	emit_signal("hit_landed")


func _on_area_entered(area: Area2D) -> void:
	apply_hit(area)
