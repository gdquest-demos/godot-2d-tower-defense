extends ProgressBar

onready var _timer := $Timer


func _on_value_changed(value: float) -> void:
	show()
	_timer.start()


func _on_Timer_timeout() -> void:
	hide()
