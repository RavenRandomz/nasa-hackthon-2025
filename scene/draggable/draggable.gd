extends Button
# This determines the state
enum {STILL, DRAG}

# When the mouse presses the button down, it saves the delta between
# the current position and the mouse position (mouse position center)
# The delta is added to the mouse position to give the new position
# When the draggable is released

func _get_global_mouse_pos():
	var viewport_origin = get_viewport_transform().get_origin()
	var viewport_mouse_pos = get_viewport().get_mouse_position()
	var global_mouse_pos = viewport_origin + viewport_mouse_pos
	return global_mouse_pos
	
var _state = STILL
var _mouse_delta = Vector2()

func _follow_cursor():
	position = _get_global_mouse_pos() + _mouse_delta
	
func _process(delta: float):
	if _state == STILL:
		_follow_cursor()


func _on_button_up() -> void:
	_state = STILL


func _on_button_down() -> void:
	_mouse_delta = position - _get_global_mouse_pos()
	_state = DRAG
