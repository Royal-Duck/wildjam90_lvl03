extends CanvasLayer

@onready var new_game_btn: Button = $Panel/CenterContainer/VBoxContainer/NewGameBtn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game_btn.pressed.connect(_on_new_game_btn_pressed)
	get_tree().paused = true

func _on_new_game_btn_pressed() -> void:
	visible = false
	get_tree().paused = false

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
