extends Sprite2D

class_name Module

var _ports: Array[Port]

var _connected_port_count = 0

func _ready():
	for child in get_children():
		if (child is Port):
			_ports.push_back(child)
		for port in _ports:
			port.port_connected.connect(_on_port_connected)
			port.port_disconnected.connect(_on_port_disconnected)

func _on_port_connected():
	_connected_port_count += 1
	print(_connected_port_count)

func _on_port_disconnected():
	_connected_port_count -= 1
	print(_connected_port_count)

func connected() -> bool:
	return _connected_port_count > 0
