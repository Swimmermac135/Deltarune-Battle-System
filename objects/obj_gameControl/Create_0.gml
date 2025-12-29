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
global.CharacterCombatRefMap = ds_map_create();

enum CHARACTERS
{
	None,
	Kris,
	Susie,
	Ralsei,
	Noelle,
	//etc
}

characterData_Kris = 
{
	
	characterName : "Kris",
	
	characterUsesAct     : true,
	
	characterPanel             : spr_BattleRoom_CharaPanel_Kris,
	characterPanelExtColor     : #00FFFF,
	characterPanelState        : CHARAPANELSTATE.CLOSED,
	characterPanelCurrentDrawY : 85,
	
	characterIcon		        : spr_BattleRoom_CharaPanelIcon_Kris,
	characterIconInjured        : spr_BattleRoom_CharaPanelIcon_KrisInjured,
	characterIconPortraitOffset : new Vector2(-79, 3),
	
	characterIconAttack  : spr_BattleRoom_CharaPanelIcon_KrisAttack,
	characterIconAct     : spr_BattleRoom_CharaPanelIcon_KrisAct,
	characterIconMagic   : spr_BattleRoom_CharaPanelIcon_KrisMagic,
	characterIconItem    : spr_BattleRoom_CharaPanelIcon_KrisItem,
	characterIconSpare   : spr_BattleRoom_CharaPanelIcon_KrisSpare,
	characterIconDefend  : spr_BattleRoom_CharaPanelIcon_KrisDefend,
	
	characterIconSleep      : spr_BattleRoom_CharaPanelIcon_KrisSleep,
	characterIconSelectHeal : spr_BattleRoom_CharaPanelIcon_KrisSelectForHeal,
	
	// Need to add: all animations, idle sprite, etc
	characterAnimationIdle  : spr_BattleRoom_CharaAnimation_KrisIdle,
	characterAnimationIntro : spr_BattleRoom_CharaAnimation_KrisAttack,
	
}

ds_map_add(global.CharacterRefMap, CHARACTERS.Kris, characterData_Kris);

characterData_Susie = 
{
	
	characterName : "Susie",
	
	characterUsesAct     : false,
	
	characterPanel             : spr_BattleRoom_CharaPanel_Susie,
	characterPanelExtColor     : #FF00FF,
	characterPanelState        : CHARAPANELSTATE.CLOSED,
	characterPanelCurrentDrawY : 85,
	
	characterIcon		        : spr_BattleRoom_CharaPanelIcon_Susie,
	characterIconInjured        : spr_BattleRoom_CharaPanelIcon_SusieInjured,
	characterIconPortraitOffset : new Vector2(-78, 3),
	
	characterIconAttack  : spr_BattleRoom_CharaPanelIcon_SusieAttack,
	characterIconAct     : spr_BattleRoom_CharaPanelIcon_SusieAct,
	characterIconMagic   : spr_BattleRoom_CharaPanelIcon_SusieMagic,
	characterIconItem    : spr_BattleRoom_CharaPanelIcon_SusieItem,
	characterIconSpare   : spr_BattleRoom_CharaPanelIcon_SusieSpare,
	characterIconDefend  : spr_BattleRoom_CharaPanelIcon_SusieDefend,
	
	characterIconSleep      : spr_BattleRoom_CharaPanelIcon_SusieSleep,
	characterIconSelectHeal : spr_BattleRoom_CharaPanelIcon_SusieSelectForHeal,
	
	characterAnimationIdle  : spr_BattleRoom_CharaAnimation_SusieIdle,
	characterAnimationIntro : spr_BattleRoom_CharaAnimation_SusieIntro,
}

ds_map_add(global.CharacterRefMap, CHARACTERS.Susie, characterData_Susie);

characterData_Ralsei = 
{
	
	characterName : "Ralsei",
	
	characterUsesAct     : false,
	
	characterPanel             : spr_BattleRoom_CharaPanel_Ralsei,
	characterPanelExtColor     : #00FF00,
	characterPanelState        : CHARAPANELSTATE.CLOSED,
	characterPanelCurrentDrawY : 85,
	
	characterIcon		        : spr_BattleRoom_CharaPanelIcon_Ralsei,
	characterIconInjured        : spr_BattleRoom_CharaPanelIcon_RalseiInjured,
	characterIconPortraitOffset : new Vector2(-76, 3),
	
	characterIconAttack  : spr_BattleRoom_CharaPanelIcon_RalseiAttack,
	characterIconAct     : spr_BattleRoom_CharaPanelIcon_RalseiAct,
	characterIconMagic   : spr_BattleRoom_CharaPanelIcon_RalseiMagic,
	characterIconItem    : spr_BattleRoom_CharaPanelIcon_RalseiItem,
	characterIconSpare   : spr_BattleRoom_CharaPanelIcon_RalseiSpare,
	characterIconDefend  : spr_BattleRoom_CharaPanelIcon_RalseiDefend,
	
	characterIconSleep      : spr_BattleRoom_CharaPanelIcon_RalseiSleep,
	characterIconSelectHeal : spr_BattleRoom_CharaPanelIcon_RalseiSelectForHeal,
	
	characterAnimationIdle  : spr_BattleRoom_CharaAnimation_RalseiIdle,
	characterAnimationIntro : spr_BattleRoom_CharaAnimation_RalseiIntro,
}

ds_map_add(global.CharacterRefMap, CHARACTERS.Ralsei, characterData_Ralsei);

// This is kind of a silly way to add an empty space in the battle but this is the simplest way to make it work
characterData_None = 
{
	
	characterName : "",
	
	characterUsesAct     : false,
	
	characterPanel             : spr_none,
	characterPanelExtColor     : $00FF00,
	characterPanelState        : CHARAPANELSTATE.CLOSED,
	characterPanelCurrentDrawY : 85,
	
	characterIcon		        : spr_none,
	characterIconInjured        : spr_none,
	characterIconPortraitOffset : new Vector2(),
	
	characterIconAttack  : spr_none,
	characterIconAct     : spr_none,
	characterIconMagic   : spr_none,
	characterIconItem    : spr_none,
	characterIconSpare   : spr_none,
	characterIconDefend  : spr_none,
	
	characterIconSleep      : spr_none,
	characterIconSelectHeal : spr_none,
	
	characterAnimationIdle  : spr_none,
	characterAnimationIntro : spr_none,
}

ds_map_add(global.CharacterRefMap, CHARACTERS.None, characterData_None);

#endregion

#region Battle Related

global.PartyArrayIndexes = [CHARACTERS.Kris, CHARACTERS.Susie, CHARACTERS.Ralsei];

global.BattleSkipIntro = true;
global.PartyArray = ds_list_create();
global.LargePartyMode = false; // This will likely remain unused for a long time. If I decide to implement it, It will allow for 6v6 fights
global.OffsetPartyDraw = false; // This is annoying but sometimes with two person parties it looks nice if the two are offset from the center instead of the side. Go look at the chapter 2 rouxls fight
global.MyFight         = true; // This one will probably actually never be needed but it is better to have it than not. All it does is remove player choice for cutscene fights like susie vs lancer in ch1

#endregion

#region Debug

global.DebugMode = true;

#endregion