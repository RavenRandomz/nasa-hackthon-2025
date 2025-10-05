extends MarginContainer

var _calculator = ResourceCalculator.new()

@export var _crew_size_input: LineEdit
@export var _mission_days_input: LineEdit

@export var _nhv_label : Label
@export var _room_areas_label : Label
@export var _room_volumes_label : Label
@export var _storage_volume_label : Label
@export var _storage_area_label : Label
@export var _food_storage_area_label : Label
@export var _total_area_label : Label


func _ready():
	_calculator.calculate(1,30)

func _update_info(data):
	_nhv_label.text = str(data["nhv"])
	_room_areas_label.text = str(data["room_areas"])
	_room_volumes_label.text = str(data["room_volumes"])
	_storage_volume_label.text = str(data["storage_volume"])
	_storage_area_label.text = str(data["storage_area"])
	_food_storage_area_label.text = str(data["food_storage_area"])
	_total_area_label.text = str(data["total_area"])
	
	

func _on_button_button_down() -> void:
	var crew_size = float(_crew_size_input.get_text())
	var mission_days = float(_mission_days_input.get_text())
	
	var data = _calculator.calculate(crew_size, mission_days)
	_update_info(data)
	
	
	
