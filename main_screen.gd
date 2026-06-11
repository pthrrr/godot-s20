extends Control


func _ready() -> void:
	$CenterContainer/VBoxContainer/StartButton.grab_focus()


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
	var game = get_tree().current_scene
	%MainMusic.play(game.music_position)


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_button_mouse_entered() -> void:
	$FocusSound.play()
