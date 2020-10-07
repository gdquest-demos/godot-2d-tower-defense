extends ProgressBar


onready var _timer := $Timer


func _on_draw() -> void:
	_timer.start()


func _on_Timer_timeout() -> void:
	hide()


func _on_value_changed(value: float) -> void:
	show()
