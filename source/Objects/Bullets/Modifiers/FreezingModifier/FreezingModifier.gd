extends Modifier


func apply_effect() -> void:
	target.speed *= 0.5


func remove_effect() -> void:
	target.speed /= 0.5
