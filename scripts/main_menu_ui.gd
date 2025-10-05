extends CanvasLayer

@onready var modeSelectScreen = "res://scenes/UI/mode_selector_screen.tscn"
@onready var instructionsScreen = ""
@onready var learnMoreScreen = ""

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(modeSelectScreen)

func _on_instructions_button_pressed() -> void:
	get_tree().change_scene_to_file(instructionsScreen)

func _on_learn_more_button_pressed() -> void:
	get_tree().change_scene_to_file(learnMoreScreen)

#TODO: Community Button

func _on_exit_button_pressed() -> void:
	get_tree().quit()
