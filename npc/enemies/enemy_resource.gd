extends Resource
class_name Enemy

@export_file("*.png", "*.jpg", "*.jpeg", "*.webp") var sprite_path: String = ""
@export_range(1, 9999, 1) var max_health: int = 10
@export_range(1, 999, 1) var attack_power: int = 2
@export_range(1, 999, 1) var attack_interval: int = 2

var current_health: int = max_health

func take_damage(amount: int) -> void:
	if amount <= 0:
		return

	current_health = max(current_health - amount, 0)

func is_dead() -> bool:
	return current_health <= 0
