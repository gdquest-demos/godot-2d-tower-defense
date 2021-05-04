class_name Tower
extends Node2D

signal sold(price, place)
signal selected(selected)

export var cost := 100

onready var _weapon := $Weapon2D
onready var _interface := $Interface
onready var _cooldown_bar := $UICooldownBar
onready var _selection := $SelectableArea2D
onready var _upgrades := $Upgrades


func _ready() -> void:
	_weapon.show_range()
	for upgrade in _upgrades.get_children():
		upgrade.weapon = _weapon
		upgrade.connect("applied", self, "_on_Upgrade_applied")


func show_interface() -> void:
	_weapon.show_range()
	_interface.appear()


func hide_interface() -> void:
	_weapon.hide_range()
	_interface.disappear()


func get_upgrades() -> Array:
	return _upgrades.get_children()


func _on_SelectableArea2D_selection_changed(selected) -> void:
	if selected:
		show_interface()
	else:
		hide_interface()
	emit_signal("selected", selected)


func _on_SellButton_pressed() -> void:
	emit_signal("sold", cost / 2, position)
	queue_free()


func _on_Weapon2D_fired() -> void:
	_cooldown_bar.start(_weapon.fire_cooldown)


func _on_Upgrade_applied(upgrade_cost: int) -> void:
	cost += upgrade_cost
