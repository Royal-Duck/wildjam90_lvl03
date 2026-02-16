extends Node2D

@onready var menu: CanvasLayer = $Menu

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		menu.visible = true
		get_tree().paused = true
