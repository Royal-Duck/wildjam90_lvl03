extends Area2D

@onready var menu: CanvasLayer = $"../Menu"
@onready var the_end_label: Label = $"../TheEndLabel"
@onready var npc: Node2D = $"../Npc"

func _ready() -> void:
	the_end_label.visible = false
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not DialogueController.is_king_flipped:
		return

	if body.is_in_group("thrown_rock"):
		body.queue_free()
		npc.stop_animation()
		npc.rotation = deg_to_rad(90)
		the_end_label.visible = true
		await get_tree().create_timer(3.0).timeout
		the_end_label.visible = false
		menu.end_game()
		return
