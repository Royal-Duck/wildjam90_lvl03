extends CanvasLayer

@onready var new_game_btn: Button = %NewGameBtn

@onready var settings_menu: VBoxContainer = %SettingsMenu
@onready var main_menu: VBoxContainer = %MainMenu

@onready var settings_btn: Button = %SettingsBtn
@onready var close_settings_btn: Button = %CloseSettingsBtn

var game_started = false

func _ready() -> void:
	get_tree().paused = true
	visible = true
	settings_menu.visible = false
	
	new_game_btn.pressed.connect(_on_new_game_btn_pressed)
	settings_btn.pressed.connect(_on_settings_menu_btn_pressed)
	close_settings_btn.pressed.connect(_on_close_settings_btn_pressed)

func _on_new_game_btn_pressed() -> void:
	get_tree().paused = false
	visible = false
	new_game_btn.text = "Back to game"

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_settings_menu_btn_pressed() -> void:
	settings_menu.visible = true
	main_menu.visible = false

func _on_close_settings_btn_pressed() -> void:
	settings_menu.visible = false
	main_menu.visible = true
