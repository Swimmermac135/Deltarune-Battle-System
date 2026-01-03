function Item(){
	
}

function OpenItemSelectScreen() 
{
	if(array_length(global.MainInventory) > 0)
	{
		global.PartyArray[| chara_currently_selecting_action].whatAmIDoingThisTurn = ACTION.ITEM;
		menu_swap_delay = 2;
		main_menu_phase = MAINMENUSTATE.SELECTINGITEM;
	}
}

function ConfirmItemUse() 
{
	audio_play_sound(snd_UTDRSelect,1,0);	
	
	var _currentChara = global.PartyArray[| chara_currently_selecting_action];
	
	_currentChara.CharaData.characterIconCurrentRender = _currentChara.CharaData.characterIconItem;
	_currentChara.thisTurnsSelectedItem = global.MainInventory[_currentChara.thisTurnsSelectedItemIndex];
	
	array_delete(global.MainInventory, _currentChara.thisTurnsSelectedItemIndex, 1);
	
	RenderPuppetPlayAnimation(_currentChara.RenderPuppet, _currentChara.CharaData.characterAnimationReadyItem[0], _currentChara.CharaData.characterAnimationReadyItem[1]);
	
	SelectNextCharacter();	
	currently_hovered_action = ACTION.ATTACK;
	main_menu_phase = MAINMENUSTATE.SELECTINGMAINACTION;
	menu_swap_delay = 2;
}

function UndoItem(){
	
	var _currentChara = global.PartyArray[| chara_currently_selecting_action];
	
	_currentChara.whatAmIDoingThisTurn         = ACTION.UNDECIDED;
	
	array_insert(global.MainInventory, _currentChara.thisTurnsSelectedItemIndex, _currentChara.thisTurnsSelectedItem);
	
	_currentChara.thisTurnsSelectedItem        = ITEMID.None;
	_currentChara.thisTurnsSelectedPartyTarget = 0;	
	_currentChara.thisTurnsSelectedItemIndex   = 0;
	_currentChara.CharaData.characterIconCurrentRender = _currentChara.CharaData.characterIcon;
	
	RenderPuppetPlayAnimation(_currentChara.RenderPuppet, _currentChara.CharaData.characterAnimationIdle[0], _currentChara.CharaData.characterAnimationIdle[1]);
	menu_swap_delay = 2;
}