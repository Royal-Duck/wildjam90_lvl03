extends CharacterBody2D

@export var speed: int = 300
@export var health: int = 100

@onready var menu: CanvasLayer = $"../Menu"
@onready var hud: CanvasLayer = $HUD
@onready var npc_interact_area: Area2D = $NpcInteractArea

var current_npc: Node2D = null

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	npc_interact_area.body_entered.connect(_on_npc_interact_area_body_entered)
	npc_interact_area.body_exited.connect(_on_npc_interact_area_body_exited)

func _physics_process(_delta: float) -> void:
	if DialogueController.is_dialogue_open:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var direction := Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if DialogueController.is_dialogue_open:
		return

	if event.is_action_pressed("interact"):
		_try_interact_with_npc()


func _try_interact_with_npc() -> void:
	if current_npc == null:
		return

	if not current_npc.is_in_group("npc"):
		return

	current_npc.hide_to_interact_press_e()
	DialogueController.start_dialogue(current_npc.data.dialogue_path)


func _on_npc_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("npc"):
		current_npc = body
		body.show_to_interact_press_e()

func _on_npc_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("npc"):
		if body == current_npc:
			current_npc = null
		body.hide_to_interact_press_e()

func take_damage(amount: int) -> void:
	health -= amount
	hud.updateHealth(health)
	if health <= 0:
		die()

func die() -> void:
	menu.game_over()
