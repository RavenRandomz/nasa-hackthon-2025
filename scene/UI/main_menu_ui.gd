extends CanvasLayer


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_learn_more_button_pressed() -> void:
	print("'Learn more button' pressed")

func _on_instructions_button_pressed() -> void:
	print("'Instructions' button pressed")

func _on_start_button_pressed() -> void:
	print("'Start button pressed'")
