extends TextureButton

signal tower_purchased(tower_scene)

export var tower_packed_scene:PackedScene = preload("res://Actors/Towers/BasicTower.tscn")
export var hover_modulate := Color(1.3, 1.3, 1.3, 1.0)
export var pressed_modulate := Color(0.7, 0.7, 0.7, 1.0)

onready var _normal_modulate = modulate


func _on_mouse_entered() -> void:
	modulate = hover_modulate


func _on_button_up() -> void:
	modulate = hover_modulate


func _on_button_down() -> void:
	modulate = pressed_modulate


func _on_mouse_exited() -> void:
	modulate = _normal_modulate


func _pressed() -> void:
	if pressed:
		emit_signal("tower_purchased", tower_packed_scene)
