extends Area2D
class_name Port

signal door_connected()
signal door_disconnected()

@onready var parent = get_parent()

var _connected_door_count = 0

func _connected_check():
	# Prevent repeats
	if _connected_door_count == 1:
		door_connected.emit()
		print("Connected")
		
func _disconnected_check():
	# Prevent false alarms if multiple intersections
	if _connected_door_count == 0:
		door_disconnected.emit()
		print("Disconnected")

func _on_area_entered(area: Area2D) -> void:
	if (typeof(area) == typeof(Port)):
		_connected_door_count += 1
		_connected_check()

func _on_area_exited(area: Area2D) -> void:
	if (typeof(area) == typeof(Port)):
		_connected_door_count -= 1
		_disconnected_check()
