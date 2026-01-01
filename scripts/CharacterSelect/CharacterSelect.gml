function SelectNextCharacter(){
	
	// This one is easy since there is code in the battlecontroller's step that autoskips any CHARACTER.NONEs
	if(ds_list_size(global.PartyArray) > chara_currently_selecting_action)
		chara_currently_selecting_action++;
	
	menu_swap_delay = 2;
}

function SelectPrevCharacter(){
	
	// This one is slightly less easy. it works though. Kind of. Mostly
	for (var _lastChara = chara_currently_selecting_action - 1; _lastChara >= 0; _lastChara--) {
	    if(global.PartyArray[| _lastChara].CharaID != CHARACTERS.None)
		{
			chara_currently_selecting_action = _lastChara;
			menu_swap_delay = 2;
			return;
		}
	}
	
}