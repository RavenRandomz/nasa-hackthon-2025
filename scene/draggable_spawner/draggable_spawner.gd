# This is designed to spawn a draggable object when clicked
# It can spawn general stuff as well when clicked
extends Button
@export var _scene_to_spawn : PackedScene
@export var _spawn_into : Node

func _on_pressed() -> void:
	pass

func _on_button_down() -> void:
	var spawned : Draggable = _scene_to_spawn.instantiate() 
	spawned.global_position = global_position
	_spawn_into.add_child(spawned)
	spawned._on_button_down()
	pass # Replace with function body.
 # Replace with function body.
