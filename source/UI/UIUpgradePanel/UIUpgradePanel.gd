extends Panel

signal upgrade_requested(upgrade_index)

onready var _options := $OptionsContainer
onready var _safe_position := get_viewport_rect().size - rect_size
onready var _original_position := rect_position


func _ready() -> void:
	for option in _options.get_children():
		var button: Button = option.get_node("UpgradeButton")
		button.connect("pressed", self, "_on_UpgradeButton_pressed", [option.get_index()])
	set_process(false)


func _process(_delta: float) -> void:
	if get_viewport_rect().encloses(get_global_rect()):
		rect_position = _original_position
	rect_global_position.x = clamp(rect_global_position.x, 0.0, _safe_position.x)
	rect_global_position.y = clamp(rect_global_position.y, 0.0, _safe_position.y)


func _on_UpgradeButton_pressed(option_index: int) -> void:
	emit_signal("upgrade_requested", option_index)


func _on_draw() -> void:
	set_process(true)


func _on_hide():
	set_process(false)

