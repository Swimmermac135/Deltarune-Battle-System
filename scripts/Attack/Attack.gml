function ConfirmAttack(){
	
	var _currentChara = global.PartyArray[| chara_currently_selecting_action];
	
	_currentChara.whatAmIDoingThisTurn                 = ACTION.ATTACK;
	_currentChara.CharaData.characterIconCurrentRender = _currentChara.CharaData.characterIconAttack;
	RenderPuppetPlayAnimation(_currentChara.RenderPuppet, _currentChara.CharaData.characterAnimationReadyAttack[0], _currentChara.CharaData.characterAnimationReadyAttack[1]);
	
	StopAllPulsing();
	
	SelectNextCharacter();
	main_menu_phase = MAINMENUSTATE.SELECTINGMAINACTION;
	menu_swap_delay = 2;
}

function SelectAttackTarget(){
	
	global.PartyArray[| chara_currently_selecting_action].whatAmIDoingThisTurn = ACTION.ATTACK;
	OpenEnemySelectorMenu();
	menu_swap_delay = 2;
	
}

function UndoAttack(){
	
	var _currentChara = global.PartyArray[| chara_currently_selecting_action];
	
	_currentChara.whatAmIDoingThisTurn                 = ACTION.UNDECIDED;
	_currentChara.thisTurnsTarget                      = 0;	
	_currentChara.CharaData.characterIconCurrentRender = _currentChara.CharaData.characterIcon;
	
	RenderPuppetPlayAnimation(_currentChara.RenderPuppet, _currentChara.CharaData.characterAnimationIdle[0], _currentChara.CharaData.characterAnimationIdle[1]);
	menu_swap_delay = 2;
	
}

function StopAllPulsing()
{
		for (var i = 0; i < ds_list_size(global.EnemyArray); i++) {
	    global.EnemyArray[| i].flash = false; // Stop flashing
	}	
}