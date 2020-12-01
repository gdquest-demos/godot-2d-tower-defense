class_name UITowerShop
extends Panel

signal tower_purchased(tower_scene)

onready var _buttons: Array = $HBoxContainer.get_children()


func _ready() -> void:
	for button in _buttons:
		button.connect("pressed", self, "_on_TowerPurchaseButton_pressed", [button.tower])


func _on_TowerPurchaseButton_pressed(tower_scene: PackedScene) -> void:
	emit_signal("tower_purchased", tower_scene)
