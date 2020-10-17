extends Camera2D

export var pan_speed := 300.0

var _velocity := Vector2.ZERO


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	var direction := global_position.direction_to(get_global_mouse_position())
	_velocity = pan_speed * direction
	translate(_velocity * delta)


func _on_Area2D_mouse_exited() -> void:
	set_process(true)


func _on_Area2D_mouse_entered() -> void:
	set_process(false)
