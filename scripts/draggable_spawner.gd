# This is designed to spawn a draggable object when clicked
# It can spawn general stuff as well when clicked
extends Button
@export var _scene_to_spawn : PackedScene
@export var _spawn_into : Node

func _get_global_mouse_pos():
	var viewport_origin = get_viewport_transform().get_origin()
	var viewport_mouse_pos = get_viewport().get_mouse_position()
	var global_mouse_pos = viewport_origin + viewport_mouse_pos
	return global_mouse_pos

func _on_pressed() -> void:
	pass

func _on_button_down() -> void:
	var spawned : Draggable = _scene_to_spawn.instantiate() 
	_spawn_into.add_child(spawned)
	var center = spawned.get_rect().size / 2
	spawned.global_position = _get_global_mouse_pos() - center
	spawned._on_button_down()
 # Replace with function body.
