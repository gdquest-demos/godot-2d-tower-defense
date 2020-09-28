extends Node2D

onready var _label := $Label
onready var _upgrades := $Upgrades
onready var _upgrade_panel := $UpgradePanel
onready var _weapon := $Weapon2D


func _ready() -> void:
	_upgrades.tower_weapon = _weapon


func _on_SelectableArea2D_selection_toggled(selected: bool) -> void:
	_label.visible = selected
	_upgrade_panel.visible = selected
