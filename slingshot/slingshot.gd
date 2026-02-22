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
	_line.default_color = Color(0.5, 0.5, 0.5, 0.6)
	add_child(_line)

func _exit_tree() -> void:
	Engine.time_scale = 1.0

const POWER_PER_SECOND : float = 500.0
const MAX_POWER : float = 800.0
const MIN_POWER : float = 150.0

func power_time(time : float) -> float:
	return clampf((-abs(time - 1.0) + 1.0) * POWER_PER_SECOND + MIN_POWER, MIN_POWER, MAX_POWER)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack_click") and not DialogueController.is_dialogue_open:
		AudioManager.play_slingshot_tension()
		

func _process(delta: float) -> void:
	Engine.time_scale = 1.0

	$basepoint.position = get_local_mouse_position().normalized() * DIST;
	var circle_pos : Vector2 = $basepoint.position;
	var angle : float = atan2(circle_pos.y, circle_pos.x);
	$basepoint.global_rotation = angle + PI / 2
	on_cooldown = clampf(on_cooldown - delta, 0.0, COOLDOWN)

	var charging: bool = Input.is_action_pressed("attack_click") and is_zero_approx(on_cooldown) and not DialogueController.is_dialogue_open
	if charging:
		_line.visible = true
		Engine.time_scale = SLOW_SCALE
		charge_time += delta / Engine.time_scale
		# Trait de visée : du lanceur, longueur qui part de 0 et grandit avec la charge (sans MIN_POWER)
		var start_pt: Vector2 = $basepoint.position + Vector2(0, -8).rotated($basepoint.rotation)
		_line.points = [start_pt, start_pt + circle_pos.normalized() * power_time(charge_time) / 4.5] if charge_time > 0 else []
		_line.default_color = Color(1, 1, 1, 0.6)
		if (0.25 > charge_time || charge_time > 1.75):
			_line.default_color = Color(0.5, 0.5, 0.5, 0.6)
		if (0.75 < charge_time && charge_time < 1.25):
			_line.default_color = Color(1.0, 0.5, 0.5, 0.6)
	if Input.is_action_just_released("attack_click") and is_zero_approx(on_cooldown) and not is_zero_approx(charge_time) and not DialogueController.is_dialogue_open:
		AudioManager.stop_slingshot_tension()
		AudioManager.play_slingshot_fire()
		on_cooldown = COOLDOWN
		var rock = THROWN_ROCK.instantiate()
		if (0.25 > charge_time || charge_time > 1.75):
			rock.damage /= 2.0
		if (0.75 < charge_time && charge_time < 1.25):
			rock.damage *= 2.0
		rock.global_position = $basepoint/launcher.global_position
		rock.add_to_group("thrown_rock")
		rock.direction = circle_pos
		rock.speed = power_time(charge_time)
		rock.max_travel = power_time(charge_time)
		rock.z_index = 8
		charge_time = 0
		get_parent().get_parent().add_child(rock)
		_line.visible = false
