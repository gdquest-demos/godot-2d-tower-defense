class_name UpgradeShop
extends Control

export var _upgrade_button_scene: PackedScene

onready var _container := $Panel/VBoxContainer
onready var _anim_player := $AnimationPlayer
onready var _panel := $Panel

var player: Player


func appear() -> void:
	# Reset rotation to appear at tower's top portion
	rect_rotation = -90
	_panel.rect_rotation = 90

	# Rotate to always display the panel on screen. Fix cases where
	# players place towers near/at screen's edges 
	if not get_viewport_rect().encloses(_panel.get_global_rect()):
		_fit_panel_in_view()
	_anim_player.play("Appear")


func disappear() -> void:
	_anim_player.play("Disappear")


func add_upgrade_button(upgrade: Upgrade) -> void:
	var button: UIUpgradeButton = _upgrade_button_scene.instance()
	button.connect("pressed", self, "_on_UIUpgradeButton_pressed", [button, upgrade])
	button.update_display(upgrade, player.gold)

	_container.add_child(button)


func _update(tower: Tower) -> void:
	rect_global_position = tower.global_position

	for child in _container.get_children():
		child.queue_free()
	
	for upgrade in tower.get_upgrades():
		add_upgrade_button(upgrade)


# Uses rotation to ensure the interface is always in the view.
func _fit_panel_in_view() -> void:
	var center := get_viewport_rect().size * 0.5
	var angle := center.angle_to_point(rect_global_position - rect_pivot_offset)
	# Snap angle to 45 degrees increment
	angle = round(angle / (PI / 4)) * (PI / 4)

	rect_rotation = rad2deg(angle)
	_panel.rect_rotation = - rect_rotation


func _on_TowerPlacer_tower_placed(tower: Tower) -> void:
	tower.connect("selected", self, "_on_Tower_selected", [tower])
	tower.connect("sold", self, "_on_Tower_sold")


func _on_Tower_selected(selected: bool, tower: Tower) -> void:
	_update(tower)

	if selected:
		appear()
	else:
		disappear()


func _on_Tower_sold(_price: int, place: Vector2) -> void:
	disappear()


func _on_UIUpgradeButton_pressed(button: UIUpgradeButton, upgrade: Upgrade) -> void:
	if player.gold < upgrade.cost:
		return
	player.gold -= upgrade.cost
	upgrade.apply()
	button.update_display(upgrade, player.gold)
