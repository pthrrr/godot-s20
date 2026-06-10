extends Control


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible:
			get_tree().quit()


func _on_start_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	get_tree().reload_current_scene()
	%MenuMusic.stop()
	%MainMusic.play()

func _on_resume_button_pressed() -> void:
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	%MenuMusic.stop()
	%MainMusic.play()


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_button_focus_entered() -> void:
	$ConfirmSound.play()


func _on_button_mouse_entered() -> void:
	$FocusSound.play()
