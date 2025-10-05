extends Node2D

@onready var sandboxScene = "res://scenes/sandbox.tscn"
@onready var levelSelectScene = ""
@onready var homeScene = "res://scenes/main_menu.tscn"


func _on_sandbox_button_pressed() -> void:
	get_tree().change_scene_to_file(sandboxScene)

func _on_levels_button_pressed() -> void:
	get_tree().change_scene_to_file(levelSelectScene)

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file(homeScene)
