extends Area2D
class_name Port

signal port_connected()
signal port_disconnected()

@onready var parent = get_parent()

var _connected_port_count = 0

func _connected_check():
	# Prevent repeats
	if _connected_port_count == 1:
		port_connected.emit()
		print("Connected")
		
func _disconnected_check():
	# Prevent false alarms if multiple intersections
	if _connected_port_count == 0:
		port_disconnected.emit()
		print("Disconnected")

func _on_area_entered(area: Area2D) -> void:
	if (area is Port):
		_connected_port_count += 1
		_connected_check()

func _on_area_exited(area: Area2D) -> void:
	if (area is Port):
		_connected_port_count -= 1
		_disconnected_check()
