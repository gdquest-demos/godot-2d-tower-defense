extends Camera2D

export var pan_speed := 300.0
export var pan_margin := 40

var _velocity := Vector2.ZERO
var _direction := Vector2.ZERO


func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	_velocity = pan_speed * _direction
	translate(_velocity * delta)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_handle_mouse(event)
	elif event is InputEventKey:
		_handle_key(event)


func _handle_mouse(event: InputEventMouseMotion) -> void:
	var mouse_position := event.global_position
	var window := OS.window_size
	_direction = Vector2.ZERO
	if mouse_position.x > window.x - pan_margin:
		_direction.x = 1
	elif mouse_position.x < 0 + pan_margin:
		_direction.x = -1
	if mouse_position.y < 0 + pan_margin:
		_direction.y = -1
	elif mouse_position.y > window.y - pan_margin:
		_direction.y = 1
	set_process(not _direction.is_equal_approx(Vector2.ZERO))


func _handle_key(_event: InputEventKey) -> void:
	_direction = Vector2.ZERO
	_direction.x = (
		Input.get_action_strength("camera_pan_right")
		- Input.get_action_strength("camera_pan_left")
	)
	_direction.y = (
		Input.get_action_strength("camera_pan_down")
		- Input.get_action_strength("camera_pan_up")
	)
	set_process(not _direction.is_equal_approx(Vector2.ZERO))
