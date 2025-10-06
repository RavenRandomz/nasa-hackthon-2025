extends CanvasLayer

@onready var homeScreenScene = "res://scenes/main_menu.tscn"

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file(homeScreenScene)
