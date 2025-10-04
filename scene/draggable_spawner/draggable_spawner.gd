# This is designed to spawn a draggable object when clicked
# It can spawn general stuff as well when clicked
extends Button
@export var _scene_to_spawn : PackedScene
@export var _spawn_into : Node

func _on_pressed() -> void:
	var spawned = _scene_to_spawn.instantiate() 
	_spawn_into.add_child(spawned)
	pass # Replace with function body.
