extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var ui_click: AudioStreamPlayer = $UIClick
@onready var slingshot_fire: AudioStreamPlayer = $SlingShotFire
@onready var slingshot_tension: AudioStreamPlayer = $SlingshotTension
@onready var bandit_death: AudioStreamPlayer = $BanditDeath
@onready var damage: AudioStreamPlayer = $Damage

func _ready() -> void:
	music_player.finished.connect(music_player.play)

func set_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(value / 100.0)
	)

func play_ui_click() -> void:
	ui_click.play(0.006)

func play_slingshot_fire() -> void:
	slingshot_fire.play()

func play_slingshot_tension() -> void:
	slingshot_tension.play()

func play_bandit_death() -> void:
	bandit_death.play()

func play_damage() -> void:
	damage.play()
