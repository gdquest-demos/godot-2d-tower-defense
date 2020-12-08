class_name Tower
extends Node2D

signal sold(price, place)

export var cost := 100

onready var _upgrades_container := $Upgrades
onready var _range_preview := $RangePreview
onready var _weapon := $Weapon2D
onready var _anim_player := $AnimationPlayer
onready var _selection := $SelectableArea2D


func _ready() -> void:
	show_interface()
	setup_upgrades()


func show_interface() -> void:
	_range_preview.radius = _weapon.fire_range
	_range_preview.appear()
	_anim_player.play("appear")


func hide_interface() -> void:
	_range_preview.disappear()
	_anim_player.play("disappear")


# TODO: refactor
func setup_upgrades() -> void:
	for upgrade in _upgrades_container.get_children():
		upgrade = upgrade as Upgrade
		upgrade.weapon = _weapon
		upgrade.connect("upgraded", self, "_on_Upgrade_upgraded")


func _on_SelectableArea2D_selection_changed(selected) -> void:
	if selected:
		show_interface()
	else:
		hide_interface()


func _on_SellButton_pressed() -> void:
	emit_signal("sold", cost * 0.5, position)
	queue_free()


func _on_UpgradePanel_upgrade_requested(upgrade_index: int) -> void:
	if _upgrades_container.get_child_count() < upgrade_index + 1:
		return
	_upgrades_container.get_child(upgrade_index).upgrade()


func _on_Upgrade_upgraded() -> void:
	_range_preview.radius = _weapon.fire_range
	_range_preview.appear()
