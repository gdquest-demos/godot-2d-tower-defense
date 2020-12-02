extends Modifier


func _apply_effect() -> void:
	target.speed *= strength


func _remove_effect() -> void:
	target.speed /= strength
