# Initializes the user interface, forwarding it the data it needs from the game world.
extends Node

onready var _player := $Player
onready var _level := $Level
onready var _hud := $UILayer/UI/HUD
onready var _tower_shop := $UILayer/UI/HUD/UITowerShop
onready var _screen_overlay := $UILayer/UI/UIScreenOverlay
onready var _mouse_barrier := $UILayer/UI/MouseBarrier
onready var _retry_button := $UILayer/UI/HUD/RetryButton
onready var _start_button := $UILayer/UI/HUD/StartWaveButton
onready var _gold_planel := $UILayer/UI/HUD/UIPlayerGold


func _ready() -> void:
	_level.tower_placer.connect("tower_placed", _tower_shop, "_on_TowerPlacer_tower_placed")
	_tower_shop.connect("tower_purchased", _level.tower_placer, "add_new_tower")
	_tower_shop.player = _player
	_gold_planel.player = _player
	_gold_planel.setup()


func _toggle_interface() -> void:
	_hud.visible = not _hud.visible
	_toggle_mouse_barrier()


# Prevents mouse interactions in play mode
func _toggle_mouse_barrier() -> void:
	_mouse_barrier.visible = not _hud.visible


func _on_StartWaveButton_pressed() -> void:
	# Enters in the "play mode". In play mode, players become passive to the
	# game's event. Interface becomes invisible and the Level starts.
	_toggle_interface()
	yield(_screen_overlay.play_wave_start_async(), "completed")
	_level.start()


func _on_Level_wave_finished() -> void:
	# Enters in the "plan mode". In plan mode, players can take actions and plan
	# their Tower Layout for the next wave. Interface becomes visible again.
	_toggle_interface()


# Lose condition
func _on_Level_base_destroyed() -> void:
	_start_button.hide()
	yield(_screen_overlay.play_lost(), "completed")
	_mouse_barrier.hide()
	_retry_button.show()


# Win condition
func _on_Level_finished() -> void:
	_screen_overlay.play_win()


func _on_RetryButton_pressed() -> void:
	get_tree().reload_current_scene()


func _on_Level_enemy_died(gold_earned) -> void:
	_player.gold += gold_earned
