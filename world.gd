extends Node2D

@export var next_scene: PackedScene

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

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "fade":
		return;
	GameManager.has_seen_start_menu = true
	GameManager.is_scene_change = true
	GameManager.is_retry = false
	get_tree().call_deferred("change_scene_to_packed", next_scene)
