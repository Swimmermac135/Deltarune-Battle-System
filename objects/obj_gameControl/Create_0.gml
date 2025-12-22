/// @description Random variable setup

#region Scribble
	scribble_font_set_default("fnt_DETERMINATION");
#endregion

#region Load Encounter Data
global.AvailableCombatEncounters = ds_list_create();

encounter_FreddyFazCrew = 
{
	displayInfo  : "Oh Cholera!",
	displayName  : "Fun Gang",
	displayLevel : "LV 2",
	stars: -1, // Later this would point to the section in save data where the completion info is
	startScript  : StartEncounter_FreddyFasbear,
}
ds_list_add(global.AvailableCombatEncounters, encounter_FreddyFazCrew);

#endregion

#region Misc Menu Function
	time_spent_holding_escape = 0;
#endregion

#region Load Character Data

global.CharacterRefMap = ds_map_create();

enum CHARACTERS
{
	Kris,
	Susie,
	Ralsei,
	Noelle,
	//etc
}

characterData_Kris = 
{
	
	characterUsesAct     : true,
	
	characterIcon		 : spr_BattleRoom_CharaPanelIcon_KrisInjured,
	characterIconInjured : spr_BattleRoom_CharaPanelIcon_Kris,
	
	characterIconAttack  : spr_BattleRoom_CharaPanelIcon_KrisAttack,
	characterIconAct     : spr_BattleRoom_CharaPanelIcon_KrisAct,
	characterIconMagic   : spr_BattleRoom_CharaPanelIcon_KrisMagic,
	characterIconItem    : spr_BattleRoom_CharaPanelIcon_KrisItem,
	characterIconSpare   : spr_BattleRoom_CharaPanelIcon_KrisSpare,
	characterIconDefend  : spr_BattleRoom_CharaPanelIcon_KrisDefend,
	
	characterIconSleep      : spr_BattleRoom_CharaPanelIcon_KrisSleep,
	characterIconSelectHeal : spr_BattleRoom_CharaPanelIcon_KrisSelectForHeal,
	
	// Need to add: all animations, idle sprite, etc
	
}

ds_map_add(global.CharacterRefMap, CHARACTERS.Kris, characterData_Kris);

characterData_Susie = 
{
	
	characterUsesAct     : false,
	
	characterIcon		 : spr_BattleRoom_CharaPanelIcon_SusieInjured,
	characterIconInjured : spr_BattleRoom_CharaPanelIcon_Susie,
	
	characterIconAttack  : spr_BattleRoom_CharaPanelIcon_SusieAttack,
	characterIconAct     : spr_BattleRoom_CharaPanelIcon_SusieAct,
	characterIconMagic   : spr_BattleRoom_CharaPanelIcon_SusieMagic,
	characterIconItem    : spr_BattleRoom_CharaPanelIcon_SusieItem,
	characterIconSpare   : spr_BattleRoom_CharaPanelIcon_SusieSpare,
	characterIconDefend  : spr_BattleRoom_CharaPanelIcon_SusieDefend,
	
	characterIconSleep      : spr_BattleRoom_CharaPanelIcon_SusieSleep,
	characterIconSelectHeal : spr_BattleRoom_CharaPanelIcon_SusieSelectForHeal,
	
}

ds_map_add(global.CharacterRefMap, CHARACTERS.Susie, characterData_Susie);

characterData_Ralsei = 
{
	
	characterUsesAct     : false,
	
	characterIcon		 : spr_BattleRoom_CharaPanelIcon_RalseiInjured,
	characterIconInjured : spr_BattleRoom_CharaPanelIcon_Ralsei,
	
	characterIconAttack  : spr_BattleRoom_CharaPanelIcon_RalseiAttack,
	characterIconAct     : spr_BattleRoom_CharaPanelIcon_RalseiAct,
	characterIconMagic   : spr_BattleRoom_CharaPanelIcon_RalseiMagic,
	characterIconItem    : spr_BattleRoom_CharaPanelIcon_RalseiItem,
	characterIconSpare   : spr_BattleRoom_CharaPanelIcon_RalseiSpare,
	characterIconDefend  : spr_BattleRoom_CharaPanelIcon_RalseiDefend,
	
	characterIconSleep      : spr_BattleRoom_CharaPanelIcon_RalseiSleep,
	characterIconSelectHeal : spr_BattleRoom_CharaPanelIcon_RalseiSelectForHeal,
	
}

ds_map_add(global.CharacterRefMap, CHARACTERS.Ralsei, characterData_Ralsei);

#endregion