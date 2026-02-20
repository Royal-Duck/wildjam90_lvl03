extends Node

var is_dialogue_open: bool = false
var current_balloon: Node = null
var path: String = ""


func start_dialogue(dialogue_path: String) -> void:
	path = dialogue_path
	var dialogue_resource := load(dialogue_path) as DialogueResource

	is_dialogue_open = true
	var balloon := DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
	if balloon == null:
		is_dialogue_open = false
		return

	current_balloon = balloon
	balloon.tree_exited.connect(_on_balloon_tree_exited, CONNECT_ONE_SHOT)


func close_current_balloon() -> void:
	if current_balloon != null:
		current_balloon.queue_free()
		current_balloon = null


func _on_balloon_tree_exited() -> void:
	current_balloon = null
	is_dialogue_open = false
	if (path == "uid://dnbvd3ee3rtde"):
		get_parent().get_child(-1).anim_player.play("fade")
