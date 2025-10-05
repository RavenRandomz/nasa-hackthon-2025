extends Node
class_name Mission

static const HEIGHT_CONSTANT = 1.91

#This requirements have been adjust to per person ratios
#static enum facilitiesRequirements{
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

#static fitnessRequirements{
	'cycle':0.845 ,
	'treadmill': 1.53,
	'resistive': .98,
}


#static crewMemberReqs{
		'sleep_relaxation': 3.49,  # Individual Quarters
		'work_surface': 4.35,  # Personal desk space
		# 1 station per 2 members
		'hygiene_cleansing': 2.175,
		'hygiene_grooming': 1.17,
		'waste_collection': 1.18
}

private total_structure_nhv, rawReqDict,  


#
#Mission:Mission(int crewSize){
	
	generateRawReqs()
	generate_total_structure_nhv.(rawReqDict)
   


}
generateRawReqs(){
	rawReqDict.append(generateMissionCrewMemberReqs)
	rawReqDict.append(genererateSpecialCrewReqs)
	rawReqDict.append(generetaFitnessRequirements)
}

generate_total_structure_nhv(dict rawReqDict){
		





}


#generetaFitnessRequirements(crew_size){

	missionFitnessFitnessReqs{str, double} = new dict

	for e in fitnessRequirements{
		missionFitnessReqs.add(e, fitnessRequirements.get(e) * crewSize)
	}

	return missionFitnessFitnessReqs
}

#generateMissionCrewMemberReqs(int crewSize){
	#similar to previous func.

}


genererateSpecialCrewReqs(int crewSize){
	
 missionCrewReqs{str, int} = {"recreation_training": 0 , "dining_table": "0"}
	
	switch (crewSize):
	case <= 4:
		missionCrewReqs.set('recreation_training': 18.20, 'dining_table': 10.09)
		break;
	case <= 6:
		missionCrewReqs.set('recreation_training': 27.30, 'dining_table': 15.14)
		break;
	default:
		missionCrewReqs.set('recreation_training': 4.55 * crewSize , 'dining_table':2.54 * crewSize )
		break;

	return missionCrewReqs    

}
