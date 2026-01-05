if(global.BattleController == -1) //Might remove this later
	global.BattleController = self;

if(keyboard_check_pressed(vk_numpad9)) {game_restart();}

if(keyboard_check_pressed(vk_numpad4) && chara_currently_selecting_action < ds_list_size(global.PartyArray)-1) {chara_currently_selecting_action++; currently_hovered_action = ACTION.ATTACK;}
if(keyboard_check_pressed(vk_numpad3) && chara_currently_selecting_action > 0) {chara_currently_selecting_action--; currently_hovered_action = ACTION.ATTACK;}

if(keyboard_check(vk_numpad1)) {AddTP(5);}
if(keyboard_check(vk_numpad2)) {RemoveTP(5);}

#region Set Up CharaData [LOAD]

if(global.BattleState == BATTLESTATE.LOAD)
{
	
	// PARTY
	for (var i = 0; i < array_length(global.PartyArrayIndexes); i++) {
		
		var _renderPuppet = instance_create_depth(chara_renderpuppet_preset_locations[i].x, chara_renderpuppet_preset_locations[i].y, i, obj_RenderPuppet);
		_renderPuppet.image_xscale = 2;
		_renderPuppet.image_yscale = 2;
		
		ds_list_add(global.PartyArray, new CharacterDataFull(global.PartyArrayIndexes[i], _renderPuppet));
		ShowDebugMessageExt("BATTLESYSTEM FULLDATA MAKER", $"Created Entry for Character {i}: {global.PartyArray[| i].CharaData.characterName}");
		
	}
	chara_renderpuppet_setup_complete = true;
	
	// ENEMIES
	// Create each enemy obj
	for (var i = 0; i < array_length(global.EnemyArrayIndexes); i++) {
		
		var _inst = instance_create_depth(enemy_renderpuppet_preset_locations[i].x, enemy_renderpuppet_preset_locations[i].y, i, ds_map_find_value(global.EnemyMap, global.EnemyArrayIndexes[i]));
		ds_list_add(global.EnemyArray, _inst);
		
		ShowDebugMessageExt("BATTLESYSTEM ENEMY CREATOR", $"Created Enemy OBJ {i}: {_inst.displayName}");
	}
	
	enemy_setup_complete = true;
}
#endregion

#region State Engine [LOAD]

// I don't know why this is in a seperate region but whatever

if(global.BattleState == BATTLESTATE.LOAD && enemy_setup_complete && chara_renderpuppet_setup_complete)
{
	if(global.BattleSkipIntro)
	{
		global.BattleState = BATTLESTATE.BATTLESTART;
		ShowDebugMessageExt("BATTLESYSTEM", "Battle LOAD Phase Complete. Proceeding to BATTLE START");
	}
	else
	{
		global.BattleState = BATTLESTATE.CHARACTERINTRO;
		//audio_play_sound(snd_DRweaponpull,1,0);
		ShowDebugMessageExt("BATTLESYSTEM", "Battle LOAD Phase Complete. Proceeding to CHARACTER INTRO");
	}
}

#endregion

#region Character Intro  [CHARACTERINTRO]

if(global.BattleState == BATTLESTATE.CHARACTERINTRO)
{
	for (var i = 0; i < ds_list_size(global.PartyArray); i++) 
	{
		var _currentEntry = global.PartyArray[| i];
		
		if(_currentEntry.RenderPuppet.currently_playing != _currentEntry.CharaData.characterAnimationIntro[0])
			RenderPuppetPlayAnimation(_currentEntry.RenderPuppet, _currentEntry.CharaData.characterAnimationIntro[0], _currentEntry.CharaData.characterAnimationIntro[1], true);
		//show_debug_message($"{_currentEntry.RenderPuppet.image_index} {_currentEntry.RenderPuppet.image_number}")	
		
		// Freeze animation if it's done
		if((HasAnimationEnded(_currentEntry.RenderPuppet) && ds_list_find_index(character_animations_complete, _currentEntry) == -1))
		{
			ds_list_add(character_animations_complete, _currentEntry)
		}
	}
	
	if(ds_list_size(character_animations_complete) >= ds_list_size(global.PartyArray))
	{
		ds_list_clear(character_animations_complete);
		global.BattleState = BATTLESTATE.BATTLESTART;
		ShowDebugMessageExt("BATTLESYSTEM", "Battle CHARACTER INTRO Phase Complete. Proceeding to BATTLE START");
	}
}

#endregion

#region BattleStart

if(global.BattleState == BATTLESTATE.BATTLESTART)
{
	
	for (var i = 0; i < ds_list_size(global.PartyArray); i++) {
		if(global.PartyArray[| i].CharaID != CHARACTERS.None)
		{
			var _currentEntry = global.PartyArray[| i];
		
			if(_currentEntry.RenderPuppet.currently_playing != _currentEntry.CharaData.characterAnimationIdle[0])
				RenderPuppetPlayAnimation(_currentEntry.RenderPuppet, _currentEntry.CharaData.characterAnimationIdle[0], _currentEntry.CharaData.characterAnimationIdle[1]);
		}
	}
	if(global.MyFight)
	{
		// Main menu and TP meter fade in
		if(!TPMeterIsIn())
			TPMeterSlideIn();
		
		if(!MainMenuIsIn())
			MainMenuSlideIn();
	}
	
	global.BattleState = BATTLESTATE.PLAYERSELECTING;
	ShowDebugMessageExt("BATTLESYSTEM", "Battle START Phase Complete. Proceeding to PLAYER TURN");
}

if(global.BattleState == BATTLESTATE.PLAYERSELECTING)
{
	// If the current character isnt real, skip to the next one
	if(ds_list_size(global.PartyArray) > chara_currently_selecting_action)
	{
		if(global.PartyArray[| chara_currently_selecting_action].CharaID == CHARACTERS.None)
			SelectNextCharacter();	
	}
	
	
	var _totalSelected = 0;
	for (var _whoToCheck = 0; _whoToCheck < ds_list_size(global.PartyArray); _whoToCheck++) {
	    if(global.PartyArray[| _whoToCheck].CharaID != CHARACTERS.None)
			if(global.PartyArray[| _whoToCheck].whatAmIDoingThisTurn != ACTION.UNDECIDED)
				_totalSelected++;
	}
	
	if(chara_currently_selecting_action >= ds_list_size(global.PartyArray))
	{
		global.BattleState = BATTLESTATE.PLAYERTOENEMYTRANSITION;
		ShowDebugMessageExt("BATTLESYSTEM", "PLAYER SELECT Phase Complete. Proceeding to PLAYER -> ENEMY TRANSITION");
	}
	

}

#endregion

#region Tension Meter

if(global.BattleState != BATTLESTATE.LOAD)
{
	
	tension_percent = global.TP / global.MaxTP;
	false_tension_percent = false_TP / global.MaxTP;
	
	if(false_TP != global.TP)
	{
		// If the change is bigger than a certain amount, skip the little delay.
		if(abs(false_TP - global.TP) > 20)
			false_TP_update += 15; 
		
		false_TP_update++;
		
		if(false_TP_update > 15)
		{
			false_TP = lerp(false_TP, global.TP, 0.15);
	
			if(abs(false_TP - global.TP) < 1)
				false_TP = global.TP;
		}
	}
	else
		false_TP_update = 0;
		
}
	
#region Meter Movement
	
if(global.TPMeterSlideIn)
{
	if(TPMeterIsIn())	
		global.TPMeterSlideIn = false;
	else
		surface_TPmeter_draw.x = slerp(surface_TPmeter_draw.x, 0, 0.25, 1);
}
	
if(global.TPMeterSlideOut)
{
	if(TPMeterIsOut())	
		global.TPMeterSlideOut = false;
	else
		surface_TPmeter_draw.x = slerp(surface_TPmeter_draw.x, -90, 0.25, 1);
}
	
#endregion



#endregion

#region Main Menu

#region MainMenu Movement
	
if(global.MainMenuSlideIn)
{
	if(WithinBounds(surface_mainmenu_draw.y, 259, 261))	
		global.MainMenuSlideIn = false;
	else
		surface_mainmenu_draw.y = slerp(surface_mainmenu_draw.y, 260, 0.25, 1);
}
	
if(global.MainMenuSlideOut)
{
	if(WithinBounds(surface_mainmenu_draw.y, 489, 491))	
		global.MainMenuSlideOut = false;
	else
		surface_mainmenu_draw.y = slerp(surface_mainmenu_draw.y, 490, 0.25, 1);
}
	
#endregion

#region Character Panel Movement

for (var i = 0; i < ds_list_size(global.PartyArray); ++i) {
	
	// Ignore if there isnt actually a character there
    if(global.PartyArray[| i].CharaID != CHARACTERS.None)
	{
		var _currentEntry = global.PartyArray[| i].CharaData;
		
		if(_currentEntry.characterPanelState == CHARAPANELSTATE.CLOSING)
		{
			_currentEntry.characterPanelCurrentDrawY = slerp(_currentEntry.characterPanelCurrentDrawY, mainmenu_charapanel_closed_y, 0.5, 1);
			
			if(_currentEntry.characterPanelCurrentDrawY == mainmenu_charapanel_closed_y)
				_currentEntry.characterPanelState = CHARAPANELSTATE.CLOSED;
		}
		
		if(_currentEntry.characterPanelState == CHARAPANELSTATE.OPENING)
		{
			_currentEntry.characterPanelCurrentDrawY = slerp(_currentEntry.characterPanelCurrentDrawY, mainmenu_charapanel_open_y, 0.5, 1);
			
			if(_currentEntry.characterPanelCurrentDrawY == mainmenu_charapanel_open_y)
				_currentEntry.characterPanelState = CHARAPANELSTATE.OPEN;
		}
	}
	
}

#endregion

#region Action Selection

// In hindsight just having a number instead of an ENUM would have worked for this
if(global.BattleState == BATTLESTATE.PLAYERSELECTING && menu_swap_delay == 0)
{

	if(main_menu_phase == MAINMENUSTATE.SELECTINGMAINACTION && menu_swap_delay == 0)
	{
		if(InputPressed(INPUT_VERB.RIGHT))
		{
			audio_play_sound(snd_UTDRSqueak,1,0);
			switch (currently_hovered_action)
			{
				case ACTION.DEFEND:
					currently_hovered_action = ACTION.ATTACK;
				break;
			
				case ACTION.ATTACK:
					currently_hovered_action = ACTION.MAGICORACT;
				break;
			
				case ACTION.MAGICORACT:
					currently_hovered_action = ACTION.ITEM;
				break;
			
				case ACTION.ITEM:
					currently_hovered_action = ACTION.SPARE;
				break;
			
				case ACTION.SPARE:
					currently_hovered_action = ACTION.DEFEND;
				break;	
			}
			
		}
	
		if(InputPressed(INPUT_VERB.LEFT))
		{
			audio_play_sound(snd_UTDRSqueak,1,0);
			switch (currently_hovered_action)
			{
				case ACTION.DEFEND:
					currently_hovered_action = ACTION.SPARE;
				break;
			
				case ACTION.SPARE:
					currently_hovered_action = ACTION.ITEM;
				break;
			
				case ACTION.ITEM:
					currently_hovered_action = ACTION.MAGICORACT;
				break;
			
				case ACTION.MAGICORACT:
					currently_hovered_action = ACTION.ATTACK;
				break;
			
				case ACTION.ATTACK:
					currently_hovered_action = ACTION.DEFEND;
				break;
		
			}
			
		}
	
		if(InputPressed(INPUT_VERB.ACCEPT))
		{
			switch (currently_hovered_action)
			{
				case ACTION.DEFEND:
					Defend();
				break;
			
				case ACTION.SPARE:
					
				break;
			
				case ACTION.ITEM:
					OpenItemSelectScreen();
				break;
			
				case ACTION.MAGICORACT:
					
				break;
			
				case ACTION.ATTACK:
					SelectAttackTarget()
				break;
			}
			audio_play_sound(snd_UTDRSelect,1,0);
		}
	
		if(InputPressed(INPUT_VERB.CANCEL))
		{
			if(chara_currently_selecting_action > 0)
			{
			
				SelectPrevCharacter();
			
				var _whatWasIDoing = global.PartyArray[| chara_currently_selecting_action].whatAmIDoingThisTurn;
				currently_hovered_action = _whatWasIDoing;
				
				switch (_whatWasIDoing)
				{
					case ACTION.DEFEND:
						UndoDefend();
					break;
			
					case ACTION.SPARE:
						//currently_hovered_action = ACTION.ITEM;
					break;
			
					case ACTION.ITEM:
						UndoItem();
					break;
			
					case ACTION.MAGICORACT:
						//currently_hovered_action = ACTION.ATTACK;
					break;
			
					case ACTION.ATTACK:
						UndoAttack();
					break;
				}
			}
			audio_play_sound(snd_UTDRSelect,1,0);
		}
	}
	
	if(main_menu_phase == MAINMENUSTATE.SELECTINGATTACKTARGET && menu_swap_delay == 0)
	{
		
		// Go up in selector list if up is pressed and not at top of list
		if(InputPressed(INPUT_VERB.UP) &&  global.PartyArray[| chara_currently_selecting_action].thisTurnsTarget > 0)
			global.PartyArray[| chara_currently_selecting_action].thisTurnsTarget--;
			
		// hover next in list if there is a next in list to hover
		if(InputPressed(INPUT_VERB.DOWN) && global.PartyArray[| chara_currently_selecting_action].thisTurnsTarget < ds_list_size(global.EnemyArray) - 1)
			global.PartyArray[| chara_currently_selecting_action].thisTurnsTarget++;
			
		if(InputPressed(INPUT_VERB.ACCEPT) && global.EnemyArray[| global.PartyArray[| chara_currently_selecting_action].thisTurnsTarget].can_be_attacked)
		{
			ConfirmAttack();
			audio_play_sound(snd_UTDRSelect,1,0);
		}
		
		if(InputPressed(INPUT_VERB.CANCEL))
		{
			StopAllPulsing();
			global.PartyArray[| chara_currently_selecting_action].thisTurnsTarget = 0;
			main_menu_phase = MAINMENUSTATE.SELECTINGMAINACTION;
		}
	}
	
	if(main_menu_phase == MAINMENUSTATE.SELECTINGITEM && menu_swap_delay == 0)
	{
		var _selectedItemIndex = global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex;
		
		// Go up in selector list if up is pressed and not at top of list
		if(InputPressed(INPUT_VERB.UP) && _selectedItemIndex > 1)
			global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex -= 2;
				
		// hover next in list if there is a next in list to hover
		if(InputPressed(INPUT_VERB.DOWN))
		{
			if(_selectedItemIndex < array_length(global.MainInventory) - 2)
				global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex += 2;
			else if(_selectedItemIndex < array_length(global.MainInventory) - 1)
				global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex += 1;
		}
		
		// This is kinda funny lmao. Left and right do the same thing. also this solution is funny
		if(InputPressed(INPUT_VERB.LEFT) || InputPressed(INPUT_VERB.RIGHT))
		{
			if(_selectedItemIndex mod 2 == 1)
				global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex--;
			else if (_selectedItemIndex mod 2 == 0 && (_selectedItemIndex < array_length(global.MainInventory) - 1))
				global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex++;
		}
		
		if(InputPressed(INPUT_VERB.ACCEPT))
		{
			// Confirm Selection
			//show_debug_message(global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex);
			var _index = global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex;
			if(ds_map_find_value(global.ItemMap, global.MainInventory[_index]).healsWholeParty == false)
			{
				main_menu_phase = MAINMENUSTATE.ITEMSELECTPARTYMEMBER;
				menu_swap_delay = 2;
				audio_play_sound(snd_UTDRSelect,1,0);
			}
			else
			{
				ConfirmItemUse();
			}
		}
		
		if(InputPressed(INPUT_VERB.CANCEL))
		{
			global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex   = 0;
			global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedPartyTarget = 0;
			main_menu_phase = MAINMENUSTATE.SELECTINGMAINACTION;
		}
	}
	
	if(main_menu_phase == MAINMENUSTATE.ITEMSELECTPARTYMEMBER && menu_swap_delay == 0)
	{
		var _selectedPartyTarget = global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedPartyTarget;
		
		// Go up in selector list if up is pressed and not at top of list
		if(InputPressed(INPUT_VERB.UP)   && _selectedPartyTarget > 0)
			global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedPartyTarget--;
				
		// hover next in list if there is a next in list to hover
		if(InputPressed(INPUT_VERB.DOWN) && _selectedPartyTarget < ds_list_size(global.PartyArray) - 1)	
			global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedPartyTarget++;
		
		if(InputPressed(INPUT_VERB.ACCEPT))
		{
			// Confirm Selection
			//show_debug_message(global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex);
			ConfirmItemUse();
		}
		
		if(InputPressed(INPUT_VERB.CANCEL))
		{
			global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedPartyTarget = 0;
			main_menu_phase = MAINMENUSTATE.SELECTINGITEM;
		}
	}
	
}

if(menu_swap_delay > 0)
	menu_swap_delay--;

#endregion

#endregion