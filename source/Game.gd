extends Node


onready var _tower_purchase_hud := $UserInterface/HUD/TowerPurcahseHBoxContainer
onready var _level := $World/Level
onready var _start_button := $UserInterface/HUD/StartWaveButton


func _ready() -> void:
	for button in _tower_purchase_hud.get_children():
		button.connect("tower_purchased", self, "_on_TowerPurchaseButton_tower_purchased")


func _toggle_interface() -> void:
	_tower_purchase_hud.visible = not _tower_purchase_hud.visible
	_start_button.disabled = not _start_button.disabled


func _on_TowerPurchaseButton_tower_purchased(tower_scene: PackedScene) -> void:
	_level.add_new_tower(tower_scene)


func _on_StartWaveButton_pressed() -> void:
	_toggle_interface()
	_level.start()


func _on_Level_wave_finished() -> void:
	_toggle_interface()
	_level.start()
