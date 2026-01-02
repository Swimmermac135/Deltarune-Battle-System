function Item(){
	
	if(array_length(global.MainInventory) > 0)
	{
		var _currentChara = global.PartyArray[| chara_currently_selecting_action];
	
		_currentChara.whatAmIDoingThisTurn                 = ACTION.ITEM;
		
		
		OpenTeammateSelectorMenu();
	}
}

function OpenItemSelectScreen() 
{
	if(array_length(global.MainInventory) > 0)
	{
		menu_swap_delay = 2;
		main_menu_phase = MAINMENUSTATE.SELECTINGITEM;
	}
}

function UndoItem(){
	
}