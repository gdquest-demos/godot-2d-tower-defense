extends Node


onready var tower_purchase_hud := $UserInterface/HUD/TowerPurcahseHBoxContainer
onready var level := $World/Level

func _ready() -> void:
	for button in tower_purchase_hud.get_children():
		button.connect("tower_purchased", self, "_on_TowerPurchaseButton_tower_purchased")


func _on_TowerPurchaseButton_tower_purchased(tower_scene: PackedScene) -> void:
	level.add_new_tower(tower_scene)
