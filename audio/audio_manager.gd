extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var ui_click: AudioStreamPlayer = $UIClick

func _ready() -> void:
	music_player.finished.connect(music_player.play)

func set_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(value / 100.0)
	)

func play_ui_click() -> void:
	ui_click.play(0.006)
