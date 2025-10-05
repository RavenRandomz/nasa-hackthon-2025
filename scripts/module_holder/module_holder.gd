extends Control

var _resource_total = ResourceTotal.new()

func scan_resources():
	for node in get_children():
		for child_node in node.get_children():
			if child_node is Module:
				_resource_total.add(child_node._resource_total)
		if node is Module:
			_resource_total.add(node._resource_total)
	print(_resource_total.data)
	
func _ready():
	scan_resources()
	
func _on_child_entered_tree(node: Node) -> void:
	pass
