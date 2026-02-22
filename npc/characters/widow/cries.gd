extends AudioStreamPlayer2D

func _on_finished() -> void:
	pitch_scale = randf() / 4.0 + 1.0
	var timer = Timer.new()
	timer.wait_time = randf() * 2.5
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
	play()
