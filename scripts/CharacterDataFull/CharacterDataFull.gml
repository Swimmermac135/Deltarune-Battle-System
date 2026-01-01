function CharacterDataFull(_CharaID, _RenderPuppet) constructor{
	
	CharaID      = _CharaID;
	RenderPuppet = _RenderPuppet;
	CharaData    = variable_clone(AnimationData_From_CharaID(_CharaID));
	CombatData   = CombatData_From_CharaID(_CharaID);
	
	whatAmIDoingThisTurn = ACTION.UNDECIDED; // What (broad category) Am I doing this turn?
	
	thisTurnsSelectedItem       = ITEMID.None;	 // If using ITEM, what item
	thisTurnsTarget       = 0;				 
	
	// Set to true if rendering will be controlled elsewhere for the renderpuppet (cutscene)
	RenderOverride = false;
}

