class_name UpgradeShop
extends Control

export var _upgrade_button_scene: PackedScene

onready var _container := $Panel/VBoxContainer
onready var _anim_player := $AnimationPlayer

var player: Player setget set_player


func set_player(new_player: Player) -> void:
	player = new_player


func add_upgrade_option(upgrade: Upgrade) -> void:
	var button: UIUpgradeButton = _upgrade_button_scene.instance()
	_container.add_child(button)

	button.connect("pressed", self, "_on_UIUpgradeButton_pressed", [button, upgrade])
	button.update_display(upgrade, player.gold)


func _update(tower: Tower) -> void:
	for child in _container.get_children():
		child.queue_free()
	
	for upgrade in tower.get_upgrades():
		add_upgrade_option(upgrade)


func _on_TowerPlacer_tower_placed(tower: Tower) -> void:
	tower.connect("selected", self, "_on_Tower_selected", [tower])
	tower.connect("sold", self, "_on_Tower_sold")


func _on_Tower_selected(selected: bool, tower: Tower) -> void:
	_update(tower)
	rect_global_position = tower.global_position

	if selected:
		_anim_player.play("Appear")
	else:
		_anim_player.play("Disappear")


func _on_Tower_sold(_price: int, place: Vector2) -> void:
	_anim_player.play("Disappear")


func _on_UIUpgradeButton_pressed(button: UIUpgradeButton, upgrade: Upgrade) -> void:
	if player.gold - upgrade.cost >= 0:
		upgrade.apply()
		player.gold -= upgrade.cost
		button.update_display(upgrade, player.gold)
