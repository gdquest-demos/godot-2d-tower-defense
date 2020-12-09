class_name UITowerShop
extends Panel

signal tower_purchased(tower_scene)

onready var _buttons: Array = $HBoxContainer.get_children()


func _ready() -> void:
	for button in _buttons:
		button.connect("pressed", self, "_on_TowerPurchaseButton_pressed", [button.tower])


func _on_TowerPurchaseButton_pressed(tower_scene: PackedScene) -> void:
	var tower: Tower = tower_scene.instance()
	tower.connect("sold", self, "_on_Tower_sold")
	emit_signal("tower_purchased", tower)


func _on_TowerPlacer_tower_placed(tower: Tower) -> void:
	Player.gold -= tower.cost


func _on_Tower_sold(price: int, position: Vector2) -> void:
	Player.gold += price
