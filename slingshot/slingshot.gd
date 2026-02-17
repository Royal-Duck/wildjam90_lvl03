extends Node2D

@export var DIST : float = 0;
@export var COOLDOWN : float = 2.5

var on_cooldown: float = 0
var charge_time: float = 0

func power_time(time : float):
	return clampf(2.0 * 2.0**-((time - 4.0) ** 2.0 / 8.0), 0.5, 4.0) * 300.0

func _process(delta: float) -> void:
	$basepoint.position = get_local_mouse_position().normalized() * DIST;
	var circle_pos : Vector2 = $basepoint.position;
	var angle : float = atan2(circle_pos.y, circle_pos.x);
	$basepoint.global_rotation = angle + PI / 2
	on_cooldown = clampf(on_cooldown - delta, 0.0, COOLDOWN)
	
	if Input.is_action_pressed("attack_click") and is_zero_approx(on_cooldown):
		charge_time += delta
	if Input.is_action_just_released("attack_click") and is_zero_approx(on_cooldown) and not is_zero_approx(charge_time):
		on_cooldown = COOLDOWN
		var rock = preload("res://slingshot/thrown_rock.tscn").instantiate()
		rock.global_position = $basepoint/launcher.global_position
		rock.direction = circle_pos
		rock.speed = power_time(charge_time)
		rock.max_travel = power_time(charge_time)
		charge_time = 0
		get_parent().get_parent().add_child(rock)

