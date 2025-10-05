extends MarginContainer

@export var _food_label : Label 
@export var _housing_label : Label 
@export var _waste_label : Label 
@export var _water_label : Label 
@export var _power_label: Label 
@export var resource_data = {
	"housing": 0,
	"food" : 0,
	"water" : 0,
	"power" : 0,
	"waste_management" : 0
	}


var score_data

func _on_update_of_score(score_data):
	_housing_label.text = str(score_data["housing"])
	_food_label.text =  str(score_data["food"])
	_water_label.text = str(score_data["water"])
	_power_label.text = str(score_data["power"])
	_waste_label.text = str(score_data["waste_management"])


func _on_shipspace_resource_changed(resource_data: Variant) -> void:
	print("Fuck")
	_on_update_of_score(resource_data)
	pass # Replace with function body.
