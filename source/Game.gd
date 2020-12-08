# Initializes the user interface, forwarding it the data it needs from the game world.
extends Node

onready var _level := $Level
onready var _hud := $UILayer/UI/HUD
onready var _tower_shop := $UILayer/UI/HUD/UITowerShop
onready var _screen_overlay := $UILayer/UI/UIScreenOverlay
onready var _mouse_barrier := $UILayer/UI/MouseBarrier
onready var _retry_button := $UILayer/UI/HUD/RetryButton
onready var _start_button := $UILayer/UI/HUD/StartWaveButton


func _ready() -> void:
	_tower_shop.tower_placer = _level.tower_placer


func _toggle_interface() -> void:
	_hud.visible = not _hud.visible
	_toggle_mouse_barrier()


# Releases the focus from other UI elements and prevents
# mouse interactions in play mode
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
