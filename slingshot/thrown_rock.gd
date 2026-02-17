extends CharacterBody2D

@export var speed : float = 400.0
@export var max_travel : int = 1200
@export var direction : Vector2 = Vector2.ZERO :
	set(value) :
		direction = value.normalized()

@onready var starting_point: Vector2 = get_global_position()

func _process(_delta : float) -> void:
	velocity = speed * direction
	move_and_slide()
	
	if (global_position - starting_point).length() > max_travel:
		queue_free()
