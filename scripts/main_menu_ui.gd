extends CanvasLayer

@onready var  sandboxStart= "res://scenes/level/editor/editor.tscn"
@onready var instructionsScreen = ""
@onready var learnMoreScreen = ""

@onready var animationPlayer = $Buttons/StartButton/AnimationPlayer

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(sandboxStart)
	animationPlayer.play("playClicksSFX")
	print("test")

func _on_instructions_button_pressed() -> void:
	get_tree().change_scene_to_file(instructionsScreen)

func _on_learn_more_button_pressed() -> void:
	get_tree().change_scene_to_file(learnMoreScreen)

#TODO: Community Button

func _on_exit_button_pressed() -> void:
	get_tree().quit()
