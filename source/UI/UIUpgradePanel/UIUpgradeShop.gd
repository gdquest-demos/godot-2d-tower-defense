class_name UpgradeShop
extends Control

export var _upgrade_button_scene: PackedScene

onready var _container := $Panel/VBoxContainer
onready var _anim_player := $AnimationPlayer

var player: Player setget set_player

func set_player(new_player: Player) -> void:
	player = new_player
	player.connect("gold_changed", self, "_on_Player_gold_changed")


func add_upgrade_option(upgrade: Upgrade) -> void:
	var button: Button = _upgrade_button_scene.instance()
	_container.add_child(button)

	button.connect("pressed", self, "_on_Button_pressed", [button])
	button.upgrade = upgrade
	button.disabled = player.gold < upgrade.cost


func _update(tower: Tower) -> void:
	for child in _container.get_children():
		child.queue_free()
	
	var upgrades := tower.get_upgrades()
	for upgrade in upgrades.get_children():
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


func _on_Button_pressed(button: UpgradeButton) -> void:
	var cost := button.get_upgrade_cost()
	if player.gold - cost >= 0:
		button.apply_upgrade()
		player.gold -= cost


func _on_Player_gold_changed(gold_amount: int) -> void:
	for button in _container.get_children():
		button.disabled = gold_amount < button.get_upgrade_cost()
