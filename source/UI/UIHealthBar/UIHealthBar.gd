extends ProgressBar

onready var _timer := $Timer


func setup(health: int, max_health: int) -> void:
	value = health
	max_value = max_health


func _on_draw() -> void:
	_timer.start()


func _on_Timer_timeout() -> void:
	hide()


func _on_owner_health_changed(new_amount) -> void:
	value = new_amount
	show()
