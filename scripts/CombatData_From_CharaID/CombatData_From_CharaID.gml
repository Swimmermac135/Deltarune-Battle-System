function CombatData_From_CharaID(Character){
	
	var ReturnVal = ds_map_find_value(global.CharacterCombatRefMap, Character);
	
	if(!is_undefined(ReturnVal))
		return ReturnVal;
	else
		return undefined; // Might change this to -1 later.
}