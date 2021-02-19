extends Sprite

export var radius := 100.0
export var tween_duration := 0.5

onready var _tween := $Tween


func appear() -> void:
	var ratio = radius / texture.get_width()
	var final_scale = Vector2(ratio, ratio) * 2.0

	_tween.stop_all()

	_tween.interpolate_property(
		self, "scale", scale, final_scale, tween_duration, Tween.TRANS_QUINT, Tween.EASE_OUT
	)
	_tween.interpolate_property(
		self, "modulate", modulate, Color(1, 1, 1, 1), tween_duration)
	_tween.start()


func disappear() -> void:
	if _tween.is_active():
		_tween.stop_all()

	_tween.interpolate_property(
		self, "scale", scale, Vector2.ZERO, tween_duration, Tween.TRANS_BACK, Tween.EASE_IN
	)
	_tween.interpolate_property(
		self, "modulate", modulate, Color(1, 1, 1, 0), tween_duration * 2.0)
	_tween.start()
