extends ProgressBar

onready var _timer := $Timer


func setup(health: int, max_health: int) -> void:
	value = health
	max_value = max_health


func _on_Timer_timeout() -> void:
	hide()


func set_current_amount(new_amount: int) -> void:
	value = new_amount
	show()
	_timer.start()
