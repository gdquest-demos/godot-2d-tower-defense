class_name UITowerShop
extends Panel

signal tower_purchased(tower)

onready var _buttons: Array = $HBoxContainer.get_children()

var player: Player setget set_player


func _ready() -> void:
	for button in _buttons:
		button.connect("tower_purchased", self, "_on_TowerPurchaseButton_tower_purchased")


func set_player(new_player: Player) -> void:
	player = new_player
	player.connect("gold_changed", self, "_on_Player_gold_changed")


func _on_TowerPurchaseButton_tower_purchased(tower_scene: PackedScene) -> void:
	var tower: Tower = tower_scene.instance()

	tower.connect("sold", self, "_on_Tower_sold")
	emit_signal("tower_purchased", tower)


func _on_TowerPlacer_tower_placed(tower: Tower) -> void:
	player.gold -= tower.cost


func _on_Tower_sold(price: int, _position: Vector2) -> void:
	player.gold += price


func _on_Player_gold_changed(gold_amount: int) -> void:
	for button in _buttons:
		button.disabled = button.tower_cost > gold_amount
