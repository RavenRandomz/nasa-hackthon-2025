extends Node
func _ready():
	var button = Button.new()
	button.pressed.connect(_button_pressed)
	add_child(button)

func _button_pressed():
	
