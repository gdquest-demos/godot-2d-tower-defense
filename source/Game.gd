# Intermediates communication between game's World and User Interface
extends Node

onready var _level := $Level
onready var _interface := $UserInterfaceLayer/UserInterface
onready var _interface_hud := $UserInterfaceLayer/UserInterface/HUD
onready var _tower_purchase_hud := $UserInterfaceLayer/UserInterface/HUD/TowerPurcahseInterface
onready var _start_button := $UserInterfaceLayer/UserInterface/HUD/StartWaveButton
onready var _overlay_animator := $UserInterfaceLayer/UserInterface/ScreenOverlay/AnimationPlayer
onready var _mouse_barrier := $UserInterfaceLayer/UserInterface/MouseBarrier
onready var _retry_button := $UserInterfaceLayer/UserInterface/HUD/RetryButton

func _ready() -> void:
	setup_tower_purchase_interface()


# Ensures the current available TowerPurchaseButtons communicate
# with the Level properly
func setup_tower_purchase_interface() -> void:
	var buttons_container := _tower_purchase_hud.find_node("TowerButtonsContainer")
	for button in buttons_container.get_children():
		if button.is_connected("tower_purchased", self, "_on_TowerPurchaseButton_tower_purchased"):
			continue
		button.connect("tower_purchased", self, "_on_TowerPurchaseButton_tower_purchased")


func _toggle_interface() -> void:
	_interface_hud.visible = not _interface_hud.visible
	_toggle_mouse_barrier()


# Releases the focus from other UI elements and prevents
# mouse interactions in play mode
func _toggle_mouse_barrier() -> void:
	_mouse_barrier.grab_focus()
	_mouse_barrier.visible = not _interface_hud.visible


func _on_TowerPurchaseButton_tower_purchased(tower_scene: PackedScene) -> void:
	# Tells the Level which Tower to place based on the Tower bought by the Player
	_level.place_new_tower(tower_scene)


func _on_StartWaveButton_pressed() -> void:
	# Enters in the "play mode". In play mode, players become passive to the
	# game's event. Interface becomes invisible and the Level starts.
	_toggle_interface()
	_overlay_animator.play("WaveStarting")
	yield(_overlay_animator, "animation_finished")
	_level.start()


func _on_Level_wave_finished() -> void:
	# Enters in the "plan mode". In plan mode, players can take actions and plan
	# their Tower Layout for the next wave. Interface becomes visible again.
	_toggle_interface()


func _on_Level_base_died() -> void:
	# Lose condition
	_mouse_barrier.hide()
	_retry_button.show()
	_overlay_animator.play("PlayerLost")


func _on_Level_finished() -> void:
	# Win condition
	_overlay_animator.play("PlayerWon")


func _on_RetryButton_pressed() -> void:
	get_tree().reload_current_scene()
