function TotalRealCharacters(){
	
	var _total = 0;
	for (var z = 0; z < ds_list_size(global.PartyArray); z++) {
	    if(global.PartyArray[| z].CharaID != CHARACTERS.None)
			_total++;
	}
	
	return _total;
}