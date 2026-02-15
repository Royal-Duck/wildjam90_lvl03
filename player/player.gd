extends CharacterBody2D


const SPEED = 300.0
@onready var npc_interact_area: Area2D = $NpcInteractArea


func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(_delta: float) -> void:
	var direction := Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()



func _on_npc_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("npc"):
		print("NPC interacted with: ", body.name)
