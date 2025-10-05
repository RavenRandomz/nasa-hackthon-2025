extends Node


const ROOM_HEIGHT_CONSTANT = 1.91

#FACILITIES REQUIREMENTS PER PERSON CONSTANT

#ROOM CATEGORIES

#ROOM SUBCATEGORIES

#DENSITY CONSTS

#MISSION DETAILS

func calculate_nhv_volume(crew_size: int, mission_days: int) -> Dictionary:
	# Base crew size
	var crew_set_per_four = ceil(crew_size / 4.0)

	# FIXED VALUES (don't change)
	var fixed_values = {
		"medical_care": 5.80,  # shared by all crew
		"medical_computer": 1.20,  # single terminal
		"command_control": 3.42,  # 2 person station
		"maintenance_computer": 3.40,
		"maintenance_workstation": 4.82,  # overlapped with EVA Suit Testing
		"meal_prep": 4.35,
		"meal_prep_table": 3.30,
		"logistics_temp_storage": 6.00,
		"waste_management": 3.76
	}
	
	# STEPPED VALUES (1 unit per 4 crew) ROUNDED UP
	var exercise_values = {
		"cycle": 3.38 * crew_set_per_four,
		"treadmill": 6.12 * crew_set_per_four,
		"resistive": 3.92 * crew_set_per_four,
	}

	# LINEAR SCALING
	var per_person = {
		"sleep_relaxation": 3.49 * crew_size,  # Individual Quarters
		"work_surface": 4.35 * crew_size,  # Personal desk space
		# 1 station per 2 members
		"hygiene_cleansing": 4.35 * ceil(crew_size / 2.0),
		"hygiene_grooming": 2.34 * ceil(crew_size / 2.0),
		"waste_collection": 2.36 * ceil(crew_size / 2.0)
	}

	# GROUP SCALING (discrete jumps by crew size)
	var group_values = {}
	if crew_size <= 4:
		group_values = {
			"recreation_training": 18.20,
			"dining_table": 10.09
		}
	elif crew_size <= 6:
		group_values = {
			"recreation_training": 27.30,
			"dining_table": 15.14
		}
	else:  # Extrapolate for larger crews
		var scaling_factor = crew_size / 6.0
		group_values = {
			"recreation_training": 27.30 * scaling_factor,
			"dining_table": 15.14 * scaling_factor
		}

	# Duration Adjustment
	var minimum_duration = 180
	var duration_factor = 1.0
	# Possible calculation for minimum (unchanged from original)

	# Calculate TOTAL NHV (cubic meters)
	var total_nhv = 0.0
	for value in fixed_values.values():
		total_nhv += value
	for value in exercise_values.values():
		total_nhv += value
	for value in per_person.values():
		total_nhv += value
	for value in group_values.values():
		total_nhv += value

	var all_values = {}
	all_values.merge(fixed_values)
	all_values.merge(exercise_values)
	all_values.merge(per_person)
	all_values.merge(group_values)

	return {"total_nhv": total_nhv, "all_values": all_values}

func calculate_room_areas(all_values: Dictionary) -> Dictionary:
	
	
	var medical = ["medical_care", "medical_computer"]
	var command_control = ["command_control"]
	var maintenance = ["maintenance_computer", "maintenance_workstation"]
	var meal_prep = ["meal_prep", "meal_prep_table"]
	var logistics_temp = ["logistics_temp_storage"]
	var waste = ["waste_management", "waste_collection"]
	var exercise = ["cycle", "treadmill", "resistive"]
	var sleep = ["sleep_relaxation"]
	var work_quarters = ["work_surface"]
	var hygiene = ["hygiene_cleansing", "hygiene_grooming"]
	var recreation_dining = ["recreation_training", "dining_table"]

	var room_types = [
		medical, command_control, maintenance, meal_prep,
		logistics_temp, waste, exercise, sleep, work_quarters, hygiene,
		recreation_dining
	]

	var room_names = [
		"medical", "command_control", "maintenance", "meal_prep", "logistics_temp",
		"waste", "exercise", "sleep", "work_quarters", "hygiene", "recreation_dining"
	]

	# Sum volumes for each room type
	var room_volumes = {}
	for i in range(room_names.size()):
		var name = room_names[i]
		var modules = room_types[i]
		var total = 0.0
		for m in modules:
			total += all_values[m]  # Add the value of each module
		room_volumes[name] = round(total * 100.0) / 100.0

	# ROUND AND DIVIDE VALUES BY HEIGHT CONSTANT TO CONVERT TO AREA
	var room_areas = {}
	for name in room_volumes.keys():
		var rawValue = room_volumes[name] / ROOM_HEIGHT_CONSTANT
		var roundedValue = round(rawValue * 100.0) / 100.0
		room_areas[name] = roundedValue

	return {"room_volumes": room_volumes, "room_areas": room_areas}

func calculate_storage_mass(crew_size: int, mission_days: int) -> Dictionary:
	# Storage scales with crew and duration

	# Calculate FOOD
	var mass_food_daily_per_person = 1.831  # kg
	var total_food_mass = mass_food_daily_per_person * crew_size * mission_days

	# WASTE COLLECTION - FECAL CANISTERS
	var mass_fecal_daily_per_person = 0.9
	var total_fecal_mass = mass_fecal_daily_per_person * crew_size * mission_days

	# WASTE COLLECTION - URINE PRE-FILTER
	var mass_urine_daily_per_person = 0.25
	var total_urine_mass = mass_urine_daily_per_person * crew_size * mission_days

	# PERSONAL HYGIENE KIT
	var mass_hygiene_kit_per_person = 1.8
	var total_hygiene_kit_mass = mass_hygiene_kit_per_person * crew_size

	# HYGIENE CONSUMABLES
	var mass_hygiene_daily_per_person = 0.079
	var total_hygiene_mass = mass_hygiene_daily_per_person * crew_size * mission_days

	# CLOTHING
	var mass_clothing_daily_per_person = 0.22
	var total_clothing_mass = mass_clothing_daily_per_person * crew_size * mission_days

	# RECREATION & PERSONAL STOWAGE
	var stowage_mass_per_person = 50 if mission_days > 365 else 25
	var total_stowage_mass = stowage_mass_per_person * crew_size

	# WIPES & TOWELS
	var mass_wipes_daily_per_person = 0.195
	var total_wipes_mass = mass_wipes_daily_per_person * crew_size * mission_days

	# TRASH BAGS
	var mass_trash_daily_per_person = 0.011
	var total_trash_mass = mass_trash_daily_per_person * crew_size * mission_days

	# OPERATIONAL SUPPLIES
	var operational_supplies_mass_per_person = 25 if mission_days > 365 else 20
	var total_operational_mass = operational_supplies_mass_per_person * crew_size

	# HEALTH CARE CONSUMABLES
	var mass_healthcare_daily_per_person = 0.09
	var total_healthcare_mass = mass_healthcare_daily_per_person * crew_size * mission_days

	return {
		"Food": total_food_mass,
		"Waste Collection - Fecal Canisters": total_fecal_mass,
		"Waste Collection - Urine Pre-filter": total_urine_mass,
		"Personal Hygiene Kit": total_hygiene_kit_mass,
		"Hygiene Consumables": total_hygiene_mass,
		"Clothing": total_clothing_mass,
		"Recreation & Personal Stowage": total_stowage_mass,
		"Wipes": total_wipes_mass,
		"Trash Bags": total_trash_mass,
		"Operational Supplies": total_operational_mass,
		"Health Care Consumables": total_healthcare_mass
	}

func calculate_storage_area(mass_dict: Dictionary, areaType: String) -> float:
	# KG per Meter^3
	var packing_densities = {
		"Food": 306,
		"Waste Collection - Fecal Canisters": 186,
		"Waste Collection - Urine Pre-filter": 186,
		"Personal Hygiene Kit": 186,
		"Hygiene Consumables": 186,
		"Clothing": 158,
		"Recreation & Personal Stowage": 235,
		"Wipes": 186,
		"Trash Bags": 186,
		"Operational Supplies": 235,
		"Health Care Consumables": 186
	}
	var total_volume = 0.0
	var total_storage_area = 0

	for item in mass_dict.keys():
		var density = packing_densities[item]
		var itemVol = mass_dict[item] / density
		total_volume += itemVol
		#print_debug(itemVol)
	var rawArea = total_volume / ROOM_HEIGHT_CONSTANT #UN TABBED to REMOVE FROM LOOP
	var roundedArea = round(rawArea * 100) / 100
	#print_debug(roundedArea)
	total_storage_area = roundedArea
	
	# FIND FOOD STORAGE VALUES
	var food_mass = mass_dict["Food"]
	var food_volume = food_mass / packing_densities["Food"]
	var food_storage_area = round(food_volume / ROOM_HEIGHT_CONSTANT * 100.0) / 100.0
	
	return food_storage_area if areaType.match("food_area") else total_storage_area

func _ready():
	# EDIT VALUES HERE
	var crew_size = 5
	var mission_days = 30

	# TOTAL STORAGE VOLUME
	var mass_dict = calculate_storage_mass(crew_size, mission_days)
	var storage_volume = calculate_storage_area(mass_dict, "total_area")
	var food_storage_area = calculate_storage_area(mass_dict, "food_area")
	var total_storage_area = round(storage_volume / ROOM_HEIGHT_CONSTANT * 100.0) / 100.0

	# TOTAL NET HABITABLE VOLUME
	var nhv_result = calculate_nhv_volume(crew_size, mission_days)
	var total_nhv = nhv_result["total_nhv"]
	var all_values = nhv_result["all_values"]

	# VOLUMES FOR EACH ROOM
	var room_result = calculate_room_areas(all_values)
	var room_volumes = room_result["room_volumes"]
	var room_areas = room_result["room_areas"]

	# TOTAL PRESSURIZED AREA
	var total_area = round(((total_nhv + total_storage_area) / ROOM_HEIGHT_CONSTANT) * 100.0) / 100.0

	print("Total NHV: ", total_nhv)
	print("Room Volumes: ", room_volumes)
	print("Room Areas: ", room_areas)
	print("Storage Volume: ", storage_volume)
	print("Storage Area: ", total_storage_area)
	print("Food Storage Area: ", food_storage_area)
	print("Total Area: ", total_area)
