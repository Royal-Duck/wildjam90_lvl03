extends Node2D

@export var DIST : float = 0;
@export var COOLDOWN : float = 2.5

# TODO: make a loading system to have stronger shots as the mouse is held
const power = 200.0

var on_cooldown: float = 0

func _process(delta: float) -> void:
	$basepoint.position = get_local_mouse_position().normalized() * DIST;
	var circle_pos : Vector2 = $basepoint.position;
	var angle : float = atan2(circle_pos.y, circle_pos.x);
	$basepoint.global_rotation = angle + PI / 2
	on_cooldown = clampf(on_cooldown - delta, 0.0, COOLDOWN)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_zero_approx(on_cooldown):
		on_cooldown = COOLDOWN
		var rock = preload("res://slingshot/thrown_rock.tscn").instantiate()
		rock.global_position = $basepoint/launcher.global_position
		rock.direction = circle_pos
		rock.speed = power
		rock.max_travel = 3.0 * power
		get_parent().get_parent().add_child(rock)
