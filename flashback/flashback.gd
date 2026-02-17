extends Node2D

@onready var go_to_flash_back_test: Area2D = $GoToFlashBackTest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	go_to_flash_back_test.body_entered.connect(_on_go_to_flash_back_test_body_entered)

func _on_go_to_flash_back_test_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.has_seen_start_menu = true
		GameManager.is_scene_change = true
		GameManager.is_retry = false
		get_tree().call_deferred("change_scene_to_file", "res://world.tscn")
