extends TextureButton

signal tower_purchased(tower_scene)

export var tower_packed_scene: PackedScene = preload("res://Actors/Towers/BasicTower.tscn")
export var hover_modulate := Color(1.3, 1.3, 1.3, 1.0)
export var pressed_modulate := Color(0.7, 0.7, 0.7, 1.0)

onready var _normal_modulate := modulate
onready var _label := $Label

var _is_mouse_on := false

func _ready() -> void:
	setup_tower_data()


func setup_tower_data() -> void:
	var tower: BasicTower = tower_packed_scene.instance()
	_label.text = "Cost: %s" % tower.cost
	tower.queue_free()


func _pressed() -> void:
	set_process(pressed)
	if pressed:
		emit_signal("tower_purchased", tower_packed_scene)
	update_modulate()


func update_modulate() -> void:
	modulate = _normal_modulate
	if pressed:
		modulate = pressed_modulate
	elif _is_mouse_on:
		modulate = hover_modulate


func _on_mouse_entered() -> void:
	_is_mouse_on = true
	update_modulate()


func _on_mouse_exited() -> void:
	_is_mouse_on = false
	update_modulate()
