extends Node2D

@export var DIST : float = 0;
@export var COOLDOWN : float = 1
@export var SLOW_SCALE : float = 0.25

const THROWN_ROCK = preload("uid://j8fd5vb3te60")

var on_cooldown: float = 0
var charge_time: float = 0
var _line: Line2D

func _ready() -> void:
	_line = Line2D.new()
	_line.width = 2.0
	_line.default_color = Color(1, 1, 1, 0.6)
	add_child(_line)

func _exit_tree() -> void:
	Engine.time_scale = 1.0

# Vitesse / distance : proportionnel au temps de charge, plafonné (plus simple et plus réactif)
const POWER_PER_SECOND : float = 500.0
const MAX_POWER : float = 1200.0
const MIN_POWER : float = 150.0

func power_time(time : float) -> float:
	return clampf(time * POWER_PER_SECOND, MIN_POWER, MAX_POWER)

func _process(delta: float) -> void:
	Engine.time_scale = 1.0

	$basepoint.position = get_local_mouse_position().normalized() * DIST;
	var circle_pos : Vector2 = $basepoint.position;
	var angle : float = atan2(circle_pos.y, circle_pos.x);
	$basepoint.global_rotation = angle + PI / 2
	on_cooldown = clampf(on_cooldown - delta, 0.0, COOLDOWN)

	var charging: bool = Input.is_action_pressed("attack_click") and is_zero_approx(on_cooldown) and not DialogueController.is_dialogue_open
	if charging:
		Engine.time_scale = SLOW_SCALE
		charge_time += delta / Engine.time_scale
	if Input.is_action_just_released("attack_click") and is_zero_approx(on_cooldown) and not is_zero_approx(charge_time) and not DialogueController.is_dialogue_open:
		on_cooldown = COOLDOWN
		var rock = THROWN_ROCK.instantiate()
		rock.global_position = $basepoint/launcher.global_position
		rock.direction = circle_pos
		rock.speed = power_time(charge_time)
		rock.max_travel = power_time(charge_time)
		charge_time = 0
		get_parent().get_parent().add_child(rock)

	# Trait de visée : du lanceur, longueur qui part de 0 et grandit avec la charge (sans MIN_POWER)
	var start_pt: Vector2 = $basepoint.position + Vector2(0, -8).rotated($basepoint.rotation)
	var line_dist: float = minf(charge_time * POWER_PER_SECOND, MAX_POWER)
	_line.points = [start_pt, start_pt + circle_pos.normalized() * line_dist] if charge_time > 0 else []
