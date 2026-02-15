extends Node

var is_dialogue_open: bool = false


func start_dialogue(dialogue_path: String) -> void:
	var dialogue_resource := load(dialogue_path) as DialogueResource

	is_dialogue_open = true
	var balloon := DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
	if balloon == null:
		is_dialogue_open = false
		return

	balloon.tree_exited.connect(_on_balloon_tree_exited, CONNECT_ONE_SHOT)


func _on_balloon_tree_exited() -> void:
	is_dialogue_open = false
