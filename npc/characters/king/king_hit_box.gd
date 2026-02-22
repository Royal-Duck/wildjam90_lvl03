extends Area2D

@onready var menu: CanvasLayer = $"../Menu"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not DialogueController.is_king_flipped:
		return

	if body.is_in_group("thrown_rock"):
		menu.end_game()
		body.queue_free()
		return
