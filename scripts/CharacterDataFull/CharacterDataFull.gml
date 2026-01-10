function CharacterDataFull(_CharaID, _RenderPuppet, _ActionOptions = [ACTION.ATTACK, ACTION.MAGIC, ACTION.ITEM, ACTION.SPARE, ACTION.DEFEND]) constructor{
	
	CharaID      = _CharaID;
	RenderPuppet = _RenderPuppet;
	CharaData    = variable_clone(AnimationData_From_CharaID(_CharaID));
	CombatData   = CombatData_From_CharaID(_CharaID);
	
	myActionOptions = _ActionOptions;            // Function to allow for custom actions
	
	thisTurnsHoveredAction = 0;
	whatAmIDoingThisTurn = ACTION.UNDECIDED;     // What (broad category) Am I doing this turn?
	
	// Item
	thisTurnsSelectedItem        = ITEMID.None;	 // If using ITEM, what item
	thisTurnsSelectedItemIndex   = 0;			 // Which index in the array (for drawing selector)
	thisTurnsSelectedPartyTarget = 0;			 // Who am I using this item on
	
	// Attack
	thisTurnsTarget       = 0;					 // If attacking	 
	
	// Set to true if rendering will be controlled elsewhere for the renderpuppet (cutscene)
	RenderOverride = false;
}

