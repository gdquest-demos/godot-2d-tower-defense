extends TextureButton

signal tower_purchased(tower_scene)

export var tower_scene: PackedScene

onready var _label := $Label

var tower_cost = 0


func _ready() -> void:
	setup_tower_data()


# Instance the Tower to access its data, e.g. cost and description
func setup_tower_data() -> void:
	var tower: Tower = tower_scene.instance()
	tower_cost = tower.cost
	_label.text = "Cost: %s" % tower_cost
	tower.queue_free()


func _pressed() -> void:
	emit_signal("tower_purchased", tower_scene)
