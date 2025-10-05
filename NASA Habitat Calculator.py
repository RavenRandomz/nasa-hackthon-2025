import math
voids_percent = 0.01

def calculate_nhv_volume(crew_size, mission_days):
    # Base crew size
    crew_set_per_four = math.ceil(crew_size / 4)

    # FIXED VALUES (dont change)
    fixed_values = {
        'medical_care': 5.80,  # shared by all crew
        'medical_computer': 1.20,  # single terminal
        'command_control': 3.42,  # 2 person station
        'maintenance_computer': 3.40,
        'maintenance_workstation': 4.82,  # overlapped with EVA Suit Testing
        'meal_prep': 4.35,
        'meal_prep_table': 3.30,
        'logistics_temp_storage': 6.00,
        'waste_management': 3.76
    }
    # STEPPED VALUES (1 unit per 4 crew) ROUNDED UP
    exercise_values = {
        'cycle': 3.38 * crew_set_per_four,
        'treadmill': 6.12 * crew_set_per_four,
        'resistive': 3.92 * crew_set_per_four,
    }

    # LINEAR SCALING
    per_person = {
        'sleep_relaxation': 3.49 * crew_size,  # Individual Quarters
        'work_surface': 4.35 * crew_size,  # Personal desk space
        # 1 station per 2 members
        'hygiene_cleansing': 4.35 * (math.ceil(crew_size / 2)),
        'hygiene_grooming': 2.34 * (math.ceil(crew_size / 2)),
        'waste_collection': 2.36 * (math.ceil(crew_size / 2))
    }

    # GROUP SCALING (discrete jumps by crew size)
    if crew_size <= 4:
        group_values = {
            'recreation_training': 18.20,
            'dining_table': 10.09
        }
    elif crew_size <= 6:
        group_values = {
            'recreation_training': 27.30,
            'dining_table': 15.14
        }
    else:  # Extrapolate for larger crews
        scaling_factor = crew_size / 6
        group_values = {
            'recreation_training': 27.30 * scaling_factor,
            'dining_table': 15.14 * scaling_factor
        }

    # Duration Adjustment
    minimum_duration = 180
    duration_factor = 1.0
    # possible calculation for minimum

    # Calculate TOTAL NHV (cubic meters)
    total_nhv = (
            sum(fixed_values.values()) +
            sum(exercise_values.values()) +
            sum(per_person.values()) +
            sum(group_values.values())
    )

    all_values = {}
    all_values.update(fixed_values)
    all_values.update(exercise_values)
    all_values.update(per_person)
    all_values.update(group_values)

    return total_nhv, all_values



def calculate_room_volumes(all_values):

    medical = ['medical_care', 'medical_computer']
    command_control = ['command_control']
    maintenance = ['maintenance_computer', 'maintenance_workstation']
    meal_prep = ['meal_prep', 'meal_prep_table']
    #EVA SUIT + AIR LOCK
    logistics_temp = ['logistics_temp_storage']
    waste = ['waste_management', 'waste_collection']
    exercise = ['cycle', 'treadmill', 'resistive']
    sleep = ['sleep_relaxation']
    work_quarters = ['work_surface']
    hygiene = ['hygiene_cleansing', 'hygiene_grooming']
    recreation_dining = ['recreation_training', 'dining_table']

    room_types = [medical,command_control,maintenance,meal_prep,
                  logistics_temp,waste,exercise,sleep,work_quarters,hygiene,
                  recreation_dining]

    room_names = ['medical', 'command_control', 'maintenance', 'meal_prep', 'logistics_temp',
                  'waste', 'exercise', 'sleep', 'work_quarters', 'hygiene', 'recreation_dining']

    # Sum volumes for each room
    room_volumes = {}
    for name, modules in zip(room_names, room_types):
        total = 0

        #Name is key of Values within room volumes
        for m in modules:
            total += all_values[m]  # Add the value of each module
        room_volumes[name] = total

    return room_volumes

def calculate_storage_mass(crew_size, mission_days):
    #storage scales with crew and Duration

    # Calculate FOOD
    mass_food_daily_per_person = 1.831 #kg
    #TOTAL MASS OF FOOD NEEDED FOR MISSION DURATION
    total_food_mass = mass_food_daily_per_person * crew_size * mission_days

    # WASTE COLLECTION - FECAL CANISTERS
    mass_fecal_daily_per_person = 0.9
    total_fecal_mass = mass_fecal_daily_per_person * crew_size * mission_days

    # WASTE COLLECTION - URINE PRE-FILTER
    mass_urine_daily_per_person = 0.25
    total_urine_mass = mass_urine_daily_per_person * crew_size * mission_days

    # PERSONAL HYGIENE KIT
    mass_hygiene_kit_per_person = 1.8
    total_hygiene_kit_mass = mass_hygiene_kit_per_person * crew_size

    # HYGIENE CONSUMABLES
    mass_hygiene_daily_per_person = 0.079
    total_hygiene_mass = mass_hygiene_daily_per_person * crew_size * mission_days

    # CLOTHING
    mass_clothing_daily_per_person = 0.22
    total_clothing_mass = mass_clothing_daily_per_person * crew_size * mission_days

    # RECREATION & PERSONAL STOWAGE
    stowage_mass_per_person = 50 if mission_days > 365 else 25
    total_stowage_mass = stowage_mass_per_person * crew_size

    # WIPES & TOWELS
    mass_wipes_daily_per_person = 0.195
    total_wipes_mass = mass_wipes_daily_per_person * crew_size * mission_days

    # TRASH BAGS
    mass_trash_daily_per_person = 0.011
    total_trash_mass = mass_trash_daily_per_person * crew_size * mission_days

    # OPERATIONAL SUPPLIES
    operational_supplies_mass_per_person = 25 if mission_days > 365 else 20
    total_operational_mass = operational_supplies_mass_per_person * crew_size

    # HEALTH CARE CONSUMABLES
    mass_healthcare_daily_per_person = 0.09
    total_healthcare_mass = mass_healthcare_daily_per_person * crew_size * mission_days

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

def calculate_storage_volume(mass_dict):
    #KG per Meter^3
    packing_densities = {
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
    total_volume = 0

    for item, mass in mass_dict.items():
        density = packing_densities[item]
        total_volume += mass * density

    return total_volume


#EDIT VALUES HERE
crew_size = 1
mission_days = 1

#TOTAL STORAGE VOLUME
mass_dict = calculate_storage_mass(crew_size,mission_days)
storage_volume = calculate_storage_volume(mass_dict)

#TOTAL NET HABITABLE VOLUME
total_nhv, all_values = calculate_nhv_volume(crew_size, mission_days)

#VOLUMES FOR EACH ROOM
room_volumes = calculate_room_volumes(all_values)

#TOTAL PRESSURIZED VOLUME
total_volume = total_nhv + storage_volume
