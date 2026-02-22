extends World

@onready var player: Node2D = $Player
@onready var mother: Node2D = $Mother
@onready var hug_animation: AnimatedSprite2D = $HugAnimation

func _ready() -> void:
	hug_animation.visible = false

func _on_npc_interact(npc: Node2D) -> void:
	if npc.name != "Mother":
		return
	player.visible = false
	mother.visible = false
	hug_animation.visible = true
	hug_animation.frame = 0
	hug_animation.play("hug")
