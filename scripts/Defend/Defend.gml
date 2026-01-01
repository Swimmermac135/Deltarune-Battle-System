function Defend(){
	
	var _currentChara = global.PartyArray[| chara_currently_selecting_action];
	
	_currentChara.whatAmIDoingThisTurn                 = ACTION.DEFEND;
	_currentChara.CharaData.characterIconCurrentRender = _currentChara.CharaData.characterIconDefend;
	RenderPuppetPlayAnimation(_currentChara.RenderPuppet, _currentChara.CharaData.characterAnimationDefend[0], _currentChara.CharaData.characterAnimationDefend[1], true);
	AddTP(16);
	SelectNextCharacter();
	currently_hovered_action = ACTION.ATTACK;

	
}

function UndoDefend(){
	
	var _currentChara = global.PartyArray[| chara_currently_selecting_action];
	
	_currentChara.whatAmIDoingThisTurn                 = ACTION.UNDECIDED;
	_currentChara.CharaData.characterIconCurrentRender = _currentChara.CharaData.characterIcon;

	RenderPuppetPlayAnimation(_currentChara.RenderPuppet, _currentChara.CharaData.characterAnimationIdle[0], _currentChara.CharaData.characterAnimationIdle[1]);
	RemoveTP(16);

}