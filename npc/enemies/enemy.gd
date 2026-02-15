extends CharacterBody2D

@export var enemy_resource: Enemy

@export var stop_distance: int = 30

@onready var attack_timer: Timer = $AttackTimer
@onready var area_2d: Area2D = $Area2D
@onready var player: Node2D = get_tree().current_scene.get_node_or_null("Player")

const SPEED = 90.0

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	area_2d.body_exited.connect(_on_area_2d_body_exited)
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	attack_timer.wait_time = enemy_resource.attack_interval

func _physics_process(_delta: float) -> void:
	if player == null:
		player = get_tree().current_scene.get_node_or_null("Player")
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var to_player: Vector2 = player.global_position - global_position
	if to_player.length() > stop_distance:
		velocity = to_player.normalized() * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		body.take_damage(enemy_resource.attack_power)
		if attack_timer.is_stopped():
			attack_timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		attack_timer.stop()

func _on_attack_timer_timeout() -> void:
	if player == null:
		return

	player.take_damage(enemy_resource.attack_power)
