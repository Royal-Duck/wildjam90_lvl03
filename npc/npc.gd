extends Node2D

@export var data: Character
@onready var to_interact_press_e: Label = $ToInteractPressE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	to_interact_press_e.visible = false

func show_to_interact_press_e() -> void:
	to_interact_press_e.visible = true

func hide_to_interact_press_e() -> void:
	to_interact_press_e.visible = false
