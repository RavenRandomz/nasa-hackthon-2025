extends CanvasLayer

func _on_home_button_pressed() -> void:
	print("HomeButton Pressed")
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func _on_right_arrow_button_pressed() -> void:
	print("rightArrowButton Pressed")


func _on_left_arrow_button_pressed() -> void:
	print("leftArrowButton Pressed")
