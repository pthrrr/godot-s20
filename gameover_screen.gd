extends Control


func _on_restart_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_button_mouse_entered() -> void:
	$FocusSound.play()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
