extends Camera2D

export var pan_speed := 300.0

var _velocity := Vector2.ZERO
var _direction := Vector2.ZERO


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	_velocity = pan_speed * _direction
	translate(_velocity * delta)


func _unhandled_input(event: InputEvent) -> void:
	_direction = Vector2.ZERO
	var horizontal := Input.is_action_pressed("camera_pan_left") or Input.is_action_pressed("camera_pan_right")
	if horizontal:
		_direction.x = Input.get_action_strength("camera_pan_right") - Input.get_action_strength("camera_pan_left")
	var vertical := Input.is_action_pressed("camera_pan_up") or Input.is_action_pressed("camera_pan_down")
	if vertical:
		_direction.y = Input.get_action_strength("camera_pan_down") - Input.get_action_strength("camera_pan_up")
	set_process(horizontal or vertical)


func _on_Area2D_mouse_exited() -> void:
	set_process(false)


func _on_Area2D_mouse_entered() -> void:
	set_process(true)


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not event is InputEventMouseMotion:
		return
	_direction = global_position.direction_to(get_global_mouse_position())
