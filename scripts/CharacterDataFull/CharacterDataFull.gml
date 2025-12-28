function CharacterDataFull(_CharaID, _RenderPuppet) constructor{
	
	CharaID        = _CharaID;
	RenderPuppet   = _RenderPuppet;
	CharaData      = CharaData_From_CharaID(_CharaID);
	
	// Set to true if rendering will be controlled elsewhere for the renderpuppet (cutscene)
	RenderOverride = false;
}

