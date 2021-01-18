extends TextureButton

signal tower_purchased

export var tower: PackedScene = preload("res://Actors/Towers/Tower.tscn")

onready var _label := $Label


func _ready() -> void:
	setup_tower_data()


# Towers are instanced to get their price
func setup_tower_data() -> void:
	var instance: Tower = tower.instance()
	_label.text = "Cost: %s" % instance.cost
	instance.queue_free()


func _pressed() -> void:
	if pressed:
		release_focus()
		emit_signal("tower_purchased", tower)
