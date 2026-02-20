extends CanvasLayer

@onready var new_game_btn: Button = %NewGameBtn

@onready var settings_menu: VBoxContainer = %SettingsMenu
@onready var main_menu: VBoxContainer = %MainMenu
@onready var game_over_menu: VBoxContainer = %GameOverMenu

@onready var settings_btn: Button = %SettingsBtn
@onready var close_settings_btn: Button = %CloseSettingsBtn

@onready var try_again_btn: Button = %TryAgainBtn
@onready var quit_game_btn: Button = %QuitGameBtn

@onready var volume_slider: HSlider = %VolumeSlider

func _ready() -> void:
	settings_menu.visible = false
	game_over_menu.visible = false
	main_menu.visible = true
	
	new_game_btn.pressed.connect(_on_new_game_btn_pressed)
	settings_btn.pressed.connect(_on_settings_menu_btn_pressed)
	close_settings_btn.pressed.connect(_on_close_settings_btn_pressed)

	try_again_btn.pressed.connect(_on_try_again_btn_pressed)
	quit_game_btn.pressed.connect(_on_quit_game_btn_pressed)

	volume_slider.min_value = 0
	volume_slider.max_value = 100
	volume_slider.value = 80
	volume_slider.value_changed.connect(_on_volume_changed)

	if not GameManager.has_seen_start_menu:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		visible = true
		new_game_btn.text = "New Game"
	else:
		get_tree().paused = false
		visible = false
		new_game_btn.text = "Back to game"

func _on_new_game_btn_pressed() -> void:
	AudioManager.play_ui_click()
	GameManager.has_seen_start_menu = true
	GameManager.is_scene_change = false
	GameManager.is_retry = false
	get_tree().paused = false
	visible = false
	new_game_btn.text = "Back to game"
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_settings_menu_btn_pressed() -> void:
	AudioManager.play_ui_click()
	settings_menu.visible = true
	main_menu.visible = false

func _on_close_settings_btn_pressed() -> void:
	AudioManager.play_ui_click()
	settings_menu.visible = false
	main_menu.visible = true

func _on_volume_changed(value: float) -> void:
	AudioManager.set_volume(value)

func game_over() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	visible = true
	main_menu.visible = false
	game_over_menu.visible = true
	get_tree().paused = true

func _on_try_again_btn_pressed() -> void:
	GameManager.has_seen_start_menu = true
	GameManager.is_scene_change = false
	GameManager.is_retry = true
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_game_btn_pressed() -> void:
	get_tree().quit()
