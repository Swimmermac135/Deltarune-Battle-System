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

#region Load Animation Data

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
	
	// This character panel stuff should probably be moved into fulldata later
	characterPanelState        : CHARAPANELSTATE.CLOSED, 
	characterPanelCurrentDrawY : 85,
	
	characterIconCurrentRender  : spr_BattleRoom_CharaPanelIcon_Kris,
	
	characterIcon		        : spr_BattleRoom_CharaPanelIcon_Kris,
	characterIconInjured        : spr_BattleRoom_CharaPanelIcon_KrisInjured,
	characterIconPortraitOffset : new Vector2(-79, 3),
	
	characterIconAttack  : spr_BattleRoom_CharaPanelIcon_KrisAttack,
	characterIconAct     : spr_BattleRoom_CharaPanelIcon_KrisAct,
	characterIconMagic   : spr_BattleRoom_CharaPanelIcon_KrisMagic,
	characterIconItem    : spr_BattleRoom_CharaPanelIcon_KrisItem,
	characterIconSpare   : spr_BattleRoom_CharaPanelIcon_KrisSpare,
	characterIconDefend  : spr_BattleRoom_CharaPanelIcon_KrisDefend,
	
	characterActionIconAttack : [spr_BattleRoom_ActionButtonIcon_Attack, spr_BattleRoom_ActionButtonIcon_AttackSelected],
	characterActionIconAct    : [spr_BattleRoom_ActionButtonIcon_Act,    spr_BattleRoom_ActionButtonIcon_ActSelected],
	characterActionIconMagic  : [spr_BattleRoom_ActionButtonIcon_Magic,  spr_BattleRoom_ActionButtonIcon_MagicSelected],
	characterActionIconItem   : [spr_BattleRoom_ActionButtonIcon_Item, spr_BattleRoom_ActionButtonIcon_ItemSelected],
	characterActionIconSpare  : [spr_BattleRoom_ActionButtonIcon_Spare, spr_BattleRoom_ActionButtonIcon_SpareSelected],
	characterActionIconDefend : [spr_BattleRoom_ActionButtonIcon_Defend, spr_BattleRoom_ActionButtonIcon_DefendSelected],
	
	characterIconSleep      : spr_BattleRoom_CharaPanelIcon_KrisSleep,
	characterIconSelectHeal : spr_BattleRoom_CharaPanelIcon_KrisSelectForHeal,
	
	// Need to add: all animations, idle sprite, etc
	characterAnimationIdle        : [spr_BattleRoom_CharaAnimation_KrisIdle , 0.16],
	characterAnimationIntro       : [spr_BattleRoom_CharaAnimation_KrisAttack, 0.5],
	characterAnimationDefend      : [spr_BattleRoom_CharaAnimation_KrisDefend, 0.5],
	characterAnimationAttack      : [spr_BattleRoom_CharaAnimation_KrisAttack, 0.5],
	characterAnimationReadyAttack : [spr_BattleRoom_CharaAnimation_KrisReadyAttack, 1],
	
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
	
	characterIconCurrentRender  : spr_BattleRoom_CharaPanelIcon_Susie,
	
	characterIcon		        : spr_BattleRoom_CharaPanelIcon_Susie,
	characterIconInjured        : spr_BattleRoom_CharaPanelIcon_SusieInjured,
	characterIconPortraitOffset : new Vector2(-78, 3),
	
	characterIconAttack  : spr_BattleRoom_CharaPanelIcon_SusieAttack,
	characterIconAct     : spr_BattleRoom_CharaPanelIcon_SusieAct,
	characterIconMagic   : spr_BattleRoom_CharaPanelIcon_SusieMagic,
	characterIconItem    : spr_BattleRoom_CharaPanelIcon_SusieItem,
	characterIconSpare   : spr_BattleRoom_CharaPanelIcon_SusieSpare,
	characterIconDefend  : spr_BattleRoom_CharaPanelIcon_SusieDefend,
	
	characterActionIconAttack : [spr_BattleRoom_ActionButtonIcon_Attack, spr_BattleRoom_ActionButtonIcon_AttackSelected],
	characterActionIconAct    : [spr_BattleRoom_ActionButtonIcon_Act,    spr_BattleRoom_ActionButtonIcon_ActSelected],
	characterActionIconMagic  : [spr_BattleRoom_ActionButtonIcon_Magic,  spr_BattleRoom_ActionButtonIcon_MagicSelected],
	characterActionIconItem   : [spr_BattleRoom_ActionButtonIcon_Item, spr_BattleRoom_ActionButtonIcon_ItemSelected],
	characterActionIconSpare  : [spr_BattleRoom_ActionButtonIcon_Spare, spr_BattleRoom_ActionButtonIcon_SpareSelected],
	characterActionIconDefend : [spr_BattleRoom_ActionButtonIcon_Defend, spr_BattleRoom_ActionButtonIcon_DefendSelected],
	
	characterIconSleep      : spr_BattleRoom_CharaPanelIcon_SusieSleep,
	characterIconSelectHeal : spr_BattleRoom_CharaPanelIcon_SusieSelectForHeal,
	
	characterAnimationIdle        : [spr_BattleRoom_CharaAnimation_SusieIdle,  0.16],
	characterAnimationIntro       : [spr_BattleRoom_CharaAnimation_SusieIntro, 0.4], // Fixing a certain (bug/behavior?) with the original game's code caused susie to get stuck in a smear frame for an unconfortably long time
	characterAnimationDefend      : [spr_BattleRoom_CharaAnimation_SusieDefend, 0.5],
	characterAnimationAttack      : [spr_BattleRoom_CharaAnimation_SusieAttack, 0.5],
	characterAnimationReadyAttack : [spr_BattleRoom_CharaAnimation_SusieReadyAttack, 1],
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
	
	characterIconCurrentRender  : spr_BattleRoom_CharaPanelIcon_Ralsei,
	
	characterIcon		        : spr_BattleRoom_CharaPanelIcon_Ralsei,
	characterIconInjured        : spr_BattleRoom_CharaPanelIcon_RalseiInjured,
	characterIconPortraitOffset : new Vector2(-76, 3),
	
	characterIconAttack  : spr_BattleRoom_CharaPanelIcon_RalseiAttack,
	characterIconAct     : spr_BattleRoom_CharaPanelIcon_RalseiAct,
	characterIconMagic   : spr_BattleRoom_CharaPanelIcon_RalseiMagic,
	characterIconItem    : spr_BattleRoom_CharaPanelIcon_RalseiItem,
	characterIconSpare   : spr_BattleRoom_CharaPanelIcon_RalseiSpare,
	characterIconDefend  : spr_BattleRoom_CharaPanelIcon_RalseiDefend,
	
	characterActionIconAttack : [spr_BattleRoom_ActionButtonIcon_Attack, spr_BattleRoom_ActionButtonIcon_AttackSelected],
	characterActionIconAct    : [spr_BattleRoom_ActionButtonIcon_Act,    spr_BattleRoom_ActionButtonIcon_ActSelected],
	characterActionIconMagic  : [spr_BattleRoom_ActionButtonIcon_Magic,  spr_BattleRoom_ActionButtonIcon_MagicSelected],
	characterActionIconItem   : [spr_BattleRoom_ActionButtonIcon_Item, spr_BattleRoom_ActionButtonIcon_ItemSelected],
	characterActionIconSpare  : [spr_BattleRoom_ActionButtonIcon_Spare, spr_BattleRoom_ActionButtonIcon_SpareSelected],
	characterActionIconDefend : [spr_BattleRoom_ActionButtonIcon_Defend, spr_BattleRoom_ActionButtonIcon_DefendSelected],
	
	characterIconSleep      : spr_BattleRoom_CharaPanelIcon_RalseiSleep,
	characterIconSelectHeal : spr_BattleRoom_CharaPanelIcon_RalseiSelectForHeal,
	
	characterAnimationIdle        : [spr_BattleRoom_CharaAnimation_RalseiIdle,  0.16],
	characterAnimationIntro       : [spr_BattleRoom_CharaAnimation_RalseiIntro, 0.6],
	characterAnimationDefend      : [spr_BattleRoom_CharaAnimation_RalseiDefend, 0.5],
	characterAnimationAttack      : [spr_BattleRoom_CharaAnimation_RalseiAttack, 0.5],
	characterAnimationReadyAttack : [spr_BattleRoom_CharaAnimation_RalseiReadyAttack, 1],
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
	
	characterIconCurrentRender  : spr_none,
	characterIcon		        : spr_none,
	characterIconInjured        : spr_none,
	characterIconPortraitOffset : new Vector2(),
	
	characterIconAttack  : spr_none,
	characterIconAct     : spr_none,
	characterIconMagic   : spr_none,
	characterIconItem    : spr_none,
	characterIconSpare   : spr_none,
	characterIconDefend  : spr_none,
	
	characterActionIconAttack : [spr_none, spr_none],
	characterActionIconAct    : [spr_none, spr_none],
	characterActionIconMagic  : [spr_none, spr_none],
	characterActionIconItem   : [spr_none, spr_none],
	characterActionIconSpare  : [spr_none, spr_none],
	characterActionIconDefend : [spr_none, spr_none],
	
	characterIconSleep      : spr_none,
	characterIconSelectHeal : spr_none,
	
	characterAnimationIdle  : [spr_none, 0],
	characterAnimationIntro : [spr_none, 0],
}

ds_map_add(global.CharacterRefMap, CHARACTERS.None, characterData_None);

#endregion

#region Load Combat Data? 

// I don't know if I will keep it like this, but being able to set combatdata independant of animdata could be useful
characterCombatData_Kris = {
		
	HP     : 90,
	maxHP  : 90,
	
	weapon     : 0,
	equipment1 : 0,
	equipment2 : 0
}

ds_map_add(global.CharacterCombatRefMap, CHARACTERS.Kris, characterCombatData_Kris);

characterCombatData_Susie = {
		
	HP     : 110,
	maxHP  : 110,
	
	weapon     : 0,
	equipment1 : 0,
	equipment2 : 0
}

ds_map_add(global.CharacterCombatRefMap, CHARACTERS.Susie, characterCombatData_Susie);

characterCombatData_Ralsei = {
		
	HP     : 70,
	maxHP  : 70,
	
	weapon     : 0,
	equipment1 : 0,
	equipment2 : 0
}

ds_map_add(global.CharacterCombatRefMap, CHARACTERS.Ralsei, characterCombatData_Ralsei);

characterCombatData_None = {
		
	HP     : 00,
	maxHP  : 01,
	
	weapon     : 0,
	equipment1 : 0,
	equipment2 : 0
}

ds_map_add(global.CharacterCombatRefMap, CHARACTERS.None, characterCombatData_None);

#endregion

#region Enemy List

// Map of enemies and their objects
global.EnemyMap = ds_map_create();

enum ENEMYID {
	
	None,
	TestEnemy,
	
}

ds_map_add(global.EnemyMap, ENEMYID.TestEnemy, obj_TestEnemy);

#endregion

#region Item List

global.ItemMap = ds_map_create();

enum ITEMTYPE {
	
	ARMOR,
	WEAPON,
	CONSUMABLE,
	OTHER,
	
}

enum ITEMID {
	
	None,
	TestArmor,
	TestConsumable,
	
}

ItemData_testArmor = {
	
	itemName    : "MaxArmor",
	description : "Raises defence to unholy levels or something",
	type        : ITEMTYPE.ARMOR, // Armor, weapon, consumable, etc
	
	canBeEquippedOn : [CHARACTERS.None],
	
	validationScript : "",
	
}

ds_map_add(global.ItemMap, ITEMID.TestArmor, ItemData_testArmor);

ItemData_testConsumable = {
	
	itemName    : "SuperFood",
	description : "Heals\n100HP",
	type        : ITEMTYPE.CONSUMABLE, // Armor, weapon, consumable, etc
	
	//canBeEquippedOn : [CHARACTERS.None],
	//consumedOnUse : false, (if item is OTHER)
	
	healsWholeParty : false,
	
	validationScript : "",
	
}

ds_map_add(global.ItemMap, ITEMID.TestConsumable, ItemData_testConsumable);

#endregion

#region Inventory

global.MainInventory = array_create(7, ITEMID.TestConsumable); // I go out of my way to make this an array instead of a ds_list because thats what it suggests
// in the manual but like its the same shit

#endregion

#region Battle Related

global.PartyArrayIndexes = [];
global.PartyArray      = ds_list_create(); // This is clearly a DS list. Why is it called PartyArray? [because it used to be an array and changing it would be annoying]

global.BattleSkipIntro  = true;
global.LargePartyMode   = false; // This will likely remain unused for a long time. If I decide to implement it, It will allow for for fights bigger than 3v3 (max 6v6 probably)
global.OffsetPartyDraw  = false; // This is annoying but sometimes with two person parties it looks nice if the two are offset from the center instead of the side. Go look at the chapter 2 rouxls fight
global.MyFight          = true; // This one will probably actually never be needed but it is better to have it than not. All it does is remove player choice for cutscene fights like susie vs lancer in ch1
global.BattleSkipEnding = false;

global.EnemyArrayIndexes = [];
global.EnemyArray        = ds_list_create(); // yet again going with this silly system. Having the fulldata creation be done in the script would be easier

#endregion

#region Debug

global.DebugMode = true;

#endregion