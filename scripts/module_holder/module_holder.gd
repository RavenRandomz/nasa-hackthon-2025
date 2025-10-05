extends Control

signal resource_changed(resource_data)

var _resource_total = ResourceTotal.new()
func _reset_resources():
	for key in _resource_total.data.keys():
		_resource_total.data[key] = 0
	
func scan_resources():
	_reset_resources()
	for node in get_children():
		for child_node in node.get_children():
			if child_node is Module:
				_resource_total.add(child_node._resource_total)
		if node is Module:
			_resource_total.add(node._resource_total)
	
func _ready():
	scan_resources()
	resource_changed.emit(_resource_total.data)
	
func _on_child_entered_tree(_node: Node) -> void:
	scan_resources()
	resource_changed.emit(_resource_total.data)
