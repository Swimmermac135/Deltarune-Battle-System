function CharacterDataFull(_CharaID, _RenderPuppet) constructor{
	
	CharaID      = _CharaID;
	RenderPuppet = _RenderPuppet;
	CharaData    = variable_clone(AnimationData_From_CharaID(_CharaID));
	CombatData   = CombatData_From_CharaID(_CharaID);
	
	whatAmIDoingThisTurn = ACTION.UNDECIDED;     // What (broad category) Am I doing this turn?
	
	thisTurnsSelectedItem        = ITEMID.None;	 // If using ITEM, what item
	thisTurnsSelectedItemIndex   = 0;			 // Which index in the array (for drawing selector)
	thisTurnsSelectedPartyTarget = 0;			 // Who am I using this item on
	
	thisTurnsTarget       = 0;					 // If attacking	 
	
	// Set to true if rendering will be controlled elsewhere for the renderpuppet (cutscene)
	RenderOverride = false;
}

