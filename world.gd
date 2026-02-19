extends Node2D

const FLASHBACK = preload("uid://brat7n62mmmdh")

@onready var go_to_flash_back_test: Area2D = $GoToFlashBackTest
@onready var menu: CanvasLayer = $Menu

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	go_to_flash_back_test.body_entered.connect(_on_go_to_flash_back_test_body_entered)

func _on_go_to_flash_back_test_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.has_seen_start_menu = true
		GameManager.is_scene_change = true
		GameManager.is_retry = false
		get_tree().call_deferred("change_scene_to_packed", FLASHBACK)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if DialogueController.is_dialogue_open:
			DialogueController.close_current_balloon()
		menu.visible = true
		get_tree().paused = true
