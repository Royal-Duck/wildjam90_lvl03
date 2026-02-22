extends CharacterBody2D

@export var enemy_resource: Enemy

@export var stop_distance: int = 30

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var dialogue_bubble: PanelContainer = $DialogueBubble
@onready var dialogue_timer: Timer = $DialogueTimer
@onready var dialogue_label: Label = %DialogueLabel

@onready var attack_timer: Timer = $AttackTimer
@onready var attack_area: Area2D = $AttackArea
@onready var agro_area: Area2D = $AgroArea

@onready var player: Node2D = get_tree().current_scene.get_node_or_null("Player")

const SPEED = 170.0

var follow_player = false
var last_direction := -1.0 # -1 gauche, 1 droite

var bandit_lines: Array[String] = [
	"You! Come here!",
	"I see you!",
	"Too late for you, stranger.",
	"This place is ours!",
	"You won't leave here alive!",
	"He's right there!",
	"He's right there!",
	"I see him!"
]

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

	dialogue_bubble.visible = false
	dialogue_timer.timeout.connect(_on_dialogue_timer_timeout)
	dialogue_timer.wait_time = 3.0

	attack_area.body_entered.connect(_on_attack_area_body_entered)
	attack_area.body_exited.connect(_on_attack_area_body_exited)
	
	agro_area.body_entered.connect(_on_agro_area_body_entered)
	agro_area.body_exited.connect(_on_agro_area_body_exited)
	
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	attack_timer.wait_time = enemy_resource.attack_interval

func _physics_process(_delta: float) -> void:
	if player == null:
		player = get_tree().current_scene.get_node_or_null("Player")
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if follow_player == true:
		var to_player: Vector2 = player.global_position - global_position
		if to_player.length() > stop_distance:
			velocity = to_player.normalized() * SPEED
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if not attack_timer.is_stopped():
		return

	var is_moving := velocity.length() > 1.0
	if is_moving:
		last_direction = 1.0 if velocity.x >= 0 else -1.0
	var anim: String
	if last_direction > 0:
		anim = "Walk_Right" if is_moving else "Idle_Right"
	else:
		anim = "Walk_Left" if is_moving else "Idle_Left"
	if animated_sprite_2d.animation != anim:
		animated_sprite_2d.play(anim)


func _on_attack_area_body_entered(body: Node2D) -> void:
	if "damage" in body:
		take_damage(body.damage)
		body.queue_free()
		return
	if body.is_in_group("player"):
		player = body
		_play_attack_animation()
		body.take_damage(enemy_resource.attack_power)
		if attack_timer.is_stopped():
			attack_timer.start()

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		attack_timer.stop()

func _on_attack_timer_timeout() -> void:
	if player == null:
		return
	_play_attack_animation()
	player.take_damage(enemy_resource.attack_power)
	
func _on_agro_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		follow_player = true
		dialogue_label.text = bandit_lines.pick_random()
		dialogue_bubble.visible = true
		dialogue_timer.start()

func _on_agro_area_body_exited(body: Node2D) -> void:
	if body == player:
		follow_player = false

func _on_dialogue_timer_timeout() -> void:
	dialogue_bubble.visible = false


func _play_attack_animation() -> void:
	var to_player := player.global_position - global_position
	last_direction = 1.0 if to_player.x >= 0 else -1.0
	var anim := "Attack_Right" if last_direction > 0 else "Attack_Left"
	animated_sprite_2d.play(anim)

func take_damage(amount: int) -> void:
	enemy_resource.take_damage(amount)
	if enemy_resource.is_dead():
		die()

func die() -> void:
	AudioManager.play_bandit_death()
	queue_free()
