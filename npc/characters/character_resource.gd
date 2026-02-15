extends Resource
class_name Character

@export var character_name: String = ""
@export_file("*.png", "*.jpg", "*.jpeg", "*.webp") var sprite_path: String = ""
@export_file("*.dialogue") var dialogue_path: String = ""

func get_sprite_texture() -> Texture2D:
	if sprite_path.is_empty():
		return null
	return load(sprite_path) as Texture2D

func get_dialogue_resource() -> Resource:
	if dialogue_path.is_empty():
		return null
	return load(dialogue_path)
