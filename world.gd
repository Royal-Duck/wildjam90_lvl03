extends Node2D

@onready var go_to_flash_back_test: Area2D = $GoToFlashBackTest
@onready var menu: CanvasLayer = $Menu
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if not menu.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if DialogueController.is_dialogue_open:
			DialogueController.close_current_balloon()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		menu.visible = true
		get_tree().paused = true


const FLASHBACK = preload("uid://brat7n62mmmdh")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "fade":
		return;
	GameManager.has_seen_start_menu = true
	GameManager.is_scene_change = true
	GameManager.is_retry = false
	get_tree().call_deferred("change_scene_to_packed", FLASHBACK)
