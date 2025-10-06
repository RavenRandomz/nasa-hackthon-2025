extends Node2D

@onready var mainMenuScene = "res://scenes/main_menu.tscn"

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file(mainMenuScene)
