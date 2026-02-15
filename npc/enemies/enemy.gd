extends CharacterBody2D


const SPEED = 90.0
const STOP_DISTANCE = 8.0

@export var enemy_resource: Enemy
@onready var player: Node2D = get_tree().current_scene.get_node_or_null("Player")

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING


func _physics_process(_delta: float) -> void:
	if player == null:
		player = get_tree().current_scene.get_node_or_null("Player")
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var to_player: Vector2 = player.global_position - global_position
	if to_player.length() > STOP_DISTANCE:
		velocity = to_player.normalized() * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
