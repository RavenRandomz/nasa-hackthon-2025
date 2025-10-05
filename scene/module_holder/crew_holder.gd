extends Control

@onready var _resource_total : ResourceTotal
	


func _on_child_entered_tree(node: Node) -> void:
	if node is Module:
		_resource_total.add(node._resource_total)
	print(_resource_total)
