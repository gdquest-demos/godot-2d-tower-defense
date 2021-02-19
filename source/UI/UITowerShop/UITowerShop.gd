class_name UITowerShop
extends Panel

signal tower_purchased(tower_scene)

onready var _buttons: Array = $HBoxContainer.get_children()

var player: Player


func _ready() -> void:
	for button in _buttons:
		button.connect("tower_purchased", self, "_on_TowerPurchaseButton_tower_purchased")


func _on_TowerPurchaseButton_tower_purchased(tower_scene: PackedScene) -> void:
	var tower: Tower = tower_scene.instance()

	if player.gold - tower.cost < 0:
		tower.queue_free()
		return

	tower.connect("sold", self, "_on_Tower_sold")
	emit_signal("tower_purchased", tower)


func _on_TowerPlacer_tower_placed(tower: Tower) -> void:
	player.gold -= tower.cost


func _on_Tower_sold(price: int, _position: Vector2) -> void:
	player.gold += price
