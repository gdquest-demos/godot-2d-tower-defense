extends Modifier


func apply_effect() -> void:
	target.speed *= strength


func remove_effect() -> void:
	target.speed /= strength
