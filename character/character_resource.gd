extends Resource
class_name Character

# Identite du personnage (nom affiche en jeu/UI/dialogue).
@export var character_name: String = ""

# Chemin vers le sprite (ex: res://assets/characters/npc.png).
@export_file("*.png", "*.jpg", "*.jpeg", "*.webp") var sprite_path: String = ""

# Chemin vers un fichier Dialogue Manager (ex: res://dialogs/wounded.dialogue).
@export_file("*.dialogue") var dialogue_path: String = ""

func get_sprite_texture() -> Texture2D:
	if sprite_path.is_empty():
		return null
	return load(sprite_path) as Texture2D

func get_dialogue_resource() -> Resource:
	if dialogue_path.is_empty():
		return null
	return load(dialogue_path)
