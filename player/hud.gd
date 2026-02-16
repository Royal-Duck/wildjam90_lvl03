extends CanvasLayer

@onready var label: Label = $MarginContainer/Label

func updateHealth(health: int) -> void:
	label.text = "Health: " + str(health)
