extends Node2D

@export var data: Character
@onready var to_interact_press_e: Label = $ToInteractPressE
@onready var area_2d: Area2D = $Area2D
@onready var dialogue_bubble: PanelContainer = $DialogueBubble
@onready var dialogue_label: Label = %DialogueLabel
@onready var bubble_timer: Timer = $BubbleTimer

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	dialogue_bubble.visible = false
	to_interact_press_e.visible = false
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	bubble_timer.timeout.connect(_on_bubble_timer_timeout)
	dialogue_label.text = data.dialogue_bubble_text

	animated_sprite_2d.sprite_frames = data.sprite_frames
	animated_sprite_2d.play("idle")

func show_to_interact_press_e() -> void:
	to_interact_press_e.visible = true

func hide_to_interact_press_e() -> void:
	to_interact_press_e.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		bubble_timer.start()
		dialogue_bubble.visible = true

func _on_bubble_timer_timeout() -> void:
	dialogue_bubble.visible = false
