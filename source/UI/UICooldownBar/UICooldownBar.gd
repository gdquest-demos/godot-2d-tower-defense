extends Control


export var gradient: Gradient

onready var _progress := $TextureProgress
onready var _animator := $AnimationPlayer
onready var _timer := $Timer


func _ready() -> void:
	set_process(false)
	hide()


func _process(delta: float) -> void:
	_progress.value = _timer.wait_time - _timer.time_left
	_progress.tint_progress = gradient.interpolate(_progress.ratio)
	if _progress.value >= _progress.max_value:
		_animator.play("Finish")
		set_process(false)


func start(time: float) -> void:
	_timer.start(time)
	_progress.max_value = time
	_progress.value = 0.0
	_animator.playback_speed = 1.0/time
	_animator.play("Spin")
	set_process(true)
	show()
