if(global.BattleState != BATTLESTATE.LOAD)
{

#region Tension Meter

//Create render target surface if it doesn't exist yet
if (!surface_exists(surface_TPmeter))
	surface_TPmeter = surface_create(96, 240);

//Set render target to correct surface and clear the surface.
surface_set_target(surface_TPmeter);
draw_clear_alpha(c_black, 0);

// Draw Meter Background
draw_sprite_ext(tensionmeter_spr_background, 0, tensionmeter_mainmeter_draw.x, tensionmeter_mainmeter_draw.y, 1, 1, 0, c_white, 1);

var drawMeterOffsetFromMaxY = (tension_percent * tensionmeter_height);
var drawCostOffsetFromMaxY  = clamp((((global.TP - global.TensionHovered) / global.MaxTP) * tensionmeter_height), 0, 200);
var drawFalseOffsetFromMaxY = (false_tension_percent * tensionmeter_height);

// Draw Meter
if(floor((global.TP / global.MaxTP) * 100) == global.MaxTP)
	draw_set_colour(tensionmeter_color_maxxed);
else
	draw_set_colour(tensionmeter_color_main);

draw_rectangle(tensionmeter_rect_topleft.x, tensionmeter_rect_btmright.y - drawMeterOffsetFromMaxY, tensionmeter_rect_btmright.x, tensionmeter_rect_btmright.y, false);
draw_set_colour(c_white);

//Draw the change meter 
if(false_TP != global.TP)
{
	if(false_TP > global.TP)
		draw_set_colour(tensionmeter_color_decrease);
	else
		draw_set_colour(tensionmeter_color_increase);
		
	draw_rectangle(tensionmeter_rect_topleft.x, tensionmeter_rect_btmright.y - drawFalseOffsetFromMaxY, tensionmeter_rect_btmright.x, tensionmeter_rect_btmright.y - drawMeterOffsetFromMaxY, false);
}


//Draw the Hovered Cost Meter
if(global.TensionHovered > 0)
{
	draw_set_colour(tensionmeter_color_hover);
	draw_set_alpha(abs(sin(tensionmeter_alpha_pulser / 8) * 0.5) + 0.25);
	
	if(global.TensionHovered > global.TP)
	{
		// Can't Afford
		draw_set_colour(tensionmeter_color_cannotafford);
		draw_set_alpha(0.7);
	}
	tensionmeter_alpha_pulser++;

	draw_rectangle(tensionmeter_rect_topleft.x, tensionmeter_rect_btmright.y - drawMeterOffsetFromMaxY, tensionmeter_rect_btmright.x, tensionmeter_rect_btmright.y - drawCostOffsetFromMaxY, false);
}
draw_set_alpha(1);

// Draw MarkerD
if(global.TP > 0 && global.TP < global.MaxTP)
	draw_sprite(tensionmeter_spr_tension_marker, 0, tensionmeter_mainmeter_draw.x, tensionmeter_rect_btmright.y - drawMeterOffsetFromMaxY);

// Draw Meter Outline
draw_sprite_ext(tensionmeter_spr_outline, 0, tensionmeter_mainmeter_draw.x, tensionmeter_mainmeter_draw.y, 1, 1, 0, c_white, 1);

// Draw Meter Cutout
gpu_set_blendmode(bm_subtract);
draw_sprite_ext(tensionmeter_spr_cutout,  0, tensionmeter_mainmeter_draw.x, tensionmeter_mainmeter_draw.y, 1, 1, 0, c_white, 1);
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_src_alpha, bm_one); // Thank you random redditor for this fix, the "update" bars (add/subtract/cost) kept setting the transparency weird.

draw_sprite_ext(tensionmeter_spr_TPicon,  0, tensionmeter_TPicon_draw.x,    tensionmeter_TPicon_draw.y,    1, 1, 0, c_white, 1);

if(floor((global.TP / global.MaxTP) * 100) < global.MaxTP)
{
	scribble($"{floor((global.TP / global.MaxTP) * 100)}").scale(.5).draw(tensionmeter_text_draw.x, tensionmeter_text_draw.y);
	scribble("%").scale(.5).draw(tensionmeter_pcnt_draw.x, tensionmeter_pcnt_draw.y);
}
else
{
	scribble("M").scale(.5).blend(tensionmeter_color_maxtextcol, 1).draw(tensionmeter_text_draw.x,     tensionmeter_text_draw.y);
	scribble("A").scale(.5).blend(tensionmeter_color_maxtextcol, 1).draw(tensionmeter_text_draw.x + 4, tensionmeter_text_draw.y + 20); 
	scribble("X").scale(.5).blend(tensionmeter_color_maxtextcol, 1).draw(tensionmeter_text_draw.x + 8, tensionmeter_text_draw.y + 40); 
}

surface_reset_target();
draw_surface(surface_TPmeter, surface_TPmeter_draw.x, surface_TPmeter_draw.y);

#endregion

#region Main Menu

// This SHOULD be enough space. 
// I Probably should have drawn this with DRAW UI but I don't like draw UI cause I have to use ratios to align things (or maybe not anymore? last time I did UI was before the UI editor update)
// Also learning how to use surfaces is fun and a nice skill to have. Also it means I dont have to add an "offset" to literally everything to animate slide in/out
// Create render target surface if it doesn't exist yet
if (!surface_exists(surface_mainmenu))
	surface_mainmenu = surface_create(640, 220); 

//Set render target to correct surface and clear the surface.
surface_set_target(surface_mainmenu);
draw_clear_alpha(c_black, 0);

//draw_sprite_ext(mainmenu_spr_background, 0, mainmenu_background_draw.x, mainmenu_background_draw.y, 10, 10, 0, c_black, 1);
//draw_sprite_ext(mainmenu_spr_background, 0, mainmenu_background_draw.x, mainmenu_background_draw.y, 1, 1, 0, c_white, 1);

// Combat Menu Background
draw_set_colour(mainmenu_col_background);
draw_rectangle(0, mainmenu_charapanel_closed_y - (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2), room_width, 480, false);
draw_set_colour(c_white);

// Combat Menu Linework
draw_set_colour(mainmenu_col_linework);
draw_line_width(0, mainmenu_charapanel_closed_y + (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2), room_width, mainmenu_charapanel_closed_y + (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2), 3);
draw_line_width(0, mainmenu_charapanel_closed_y - (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2), room_width, mainmenu_charapanel_closed_y - (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2), 3);
draw_set_colour(c_white);

// The main menu sub menus

switch(main_menu_phase)
{
	case MAINMENUSTATE.SELECTINGMAINACTION:
		// Keep the typewriter visible i think idk i just need this here for now
	break;
	
	// This probably also works for selecting ACT target (not selecting an act)
	case MAINMENUSTATE.SELECTINGATTACKTARGET:
		#region Selecting Attack Target

		draw_sprite_ext(spr_BattleRoom_Mercy, 0, 560, 113, 0.5, 0.3, 0, c_white, 1);
		draw_sprite_ext(spr_BattleRoom_HP, 0, 435, 113, 0.5, 0.3, 0, c_white, 1);
		
		// Do not go into github history and look at the v1 version of this code, worst mistake of my life
		
		var _page = floor(global.PartyArray[| chara_currently_selecting_action].thisTurnsTarget / 3);
		var _amountOnCurrentPage = clamp(array_length(global.MainInventory) - (_page * 3), 0, 3);
		var _selectedEnemy =  global.PartyArray[| chara_currently_selecting_action].thisTurnsTarget;
		
		for (var _row = 0; _row < _amountOnCurrentPage; _row++) {
			var _currentEnemy = global.EnemyArray[| _selectedEnemy];
			
			scribble(_currentEnemy.displayName).scale(.5).draw(80, 115 + _row * (item_readout_px.y + item_readout_padding));
			
			var _healthPercent = (_currentEnemy.HP / _currentEnemy.max_HP) * 100;
			
			// Health Meter
			draw_healthbar(415, 137 + _row * (item_readout_px.y + item_readout_padding), 498, 120 + _row * (item_readout_px.y + item_readout_padding), _healthPercent, _currentEnemy.health_color.y, _currentEnemy.health_color.x, _currentEnemy.health_color.x, 0, true, false);
			// Mercy Meter
			draw_healthbar(518, 137 + _row * (item_readout_px.y + item_readout_padding), 603, 120 + _row * (item_readout_px.y + item_readout_padding), _currentEnemy.spare_percent, _currentEnemy.mercy_color.y, _currentEnemy.mercy_color.x, _currentEnemy.mercy_color.x, 0, true, false);
			
			if(_currentEnemy.health_percent_unknown)
				scribble("???").transform(.5, .25, 0).flash(_currentEnemy.health_text_color, 1).draw(417, 121 + _row * (item_readout_px.y + item_readout_padding));
			else
				scribble($"{round(_healthPercent)}%").transform(.5, .25, 0).flash(_currentEnemy.health_text_color, 1).draw(417, 121 + _row * (item_readout_px.y + item_readout_padding));
			
			if(_currentEnemy.can_be_spared) // Update later to draw the x over the mercy meter if the enemy cannot be spared at all. I am leaving this unimplemented for now
				scribble($"{_currentEnemy.spare_percent}%").transform(.5, .25, 0).flash(_currentEnemy.mercy_text_color, 1).draw(523, 121 + _row * (item_readout_px.y + item_readout_padding));
			
			if(_selectedEnemy == (_row + (_page * 3))) // Draw soul next to the hovered option
				draw_sprite(current_selector_icon, 0, 65, 130 + _row * (item_readout_px.y + item_readout_padding));
		}
		
		// Arrows to indicate other pages of enemies
		if(_page > 0)
			draw_sprite_ext(spr_BattleRoom_Arrow, 0, 625, 130 - (abs(sin(item_readout_arrow_sinpulser / 8)) + 0.25) * 5, 1, 1, 180, c_white, 1);
			
		if(ds_list_size(global.PartyArray) > (_page + 1) * 3)
			draw_sprite_ext(spr_BattleRoom_Arrow, 0, 625, 190 + (abs(sin(item_readout_arrow_sinpulser / 8)) + 0.25) * 5, 1, 1, 0, c_white, 1);
		
		item_readout_arrow_sinpulser += .75;
		
		#endregion
	break;
	
	case MAINMENUSTATE.SELECTINGITEM:
		#region Items
		// We need three rows of two items each. I don't want to use the code from the other rendering type so... it is time to write something actually "good"
		var _page = floor(global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex / 6);
		var _amountOnCurrentPage = clamp(array_length(global.MainInventory) - (_page * 6), 0, 6); // I think this will work, if over 6 and on page 0 then six 
		
		for (var _row = 0; _row < _amountOnCurrentPage; _row++) {
			var _item = ds_map_find_value(global.ItemMap, global.MainInventory[_row + (_page * 6)]); // Find current item with page offset
			scribble(_item.itemName).scale(.5).draw(35 + item_readout_px.x * (_row mod 2), 115 + floor(_row / 2) * (item_readout_px.y + item_readout_padding)); // Draw it in a convoluted way
			
			if(global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedItemIndex == (_row + (_page * 6)))
			{
				draw_sprite(current_selector_icon, 0, 20 + item_readout_px.x * (_row mod 2), 130 + floor(_row / 2) * (item_readout_px.y + item_readout_padding));
				scribble(_item.description).scale(.5).line_spacing("90%").draw(80 + item_readout_px.x * 2, 115);
			}
		}
		
		// Arrows to indicate other pages of items
		if(_page > 0)
			draw_sprite_ext(spr_BattleRoom_Arrow, 0, 465, 130 - (abs(sin(item_readout_arrow_sinpulser / 8)) + 0.25) * 5, 1, 1, 180, c_white, 1);
			
		if(array_length(global.MainInventory) > (_page + 1) * 6)
			draw_sprite_ext(spr_BattleRoom_Arrow, 0, 465, 190 + (abs(sin(item_readout_arrow_sinpulser / 8)) + 0.25) * 5, 1, 1, 0, c_white, 1);
		
		item_readout_arrow_sinpulser += .75;
		
		#endregion
	break;
	
	case MAINMENUSTATE.ITEMSELECTPARTYMEMBER:
		#region Party Readout
		// One column of three
		var _page = floor(global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedPartyTarget / 3);
		var _amountOnCurrentPage = clamp(ds_list_size(global.PartyArray) - (_page * 3), 0, 3);
			
		for (var _row = 0; _row < _amountOnCurrentPage; _row++) {
			var _partyMember = global.PartyArray[| _row];
			scribble(_partyMember.CharaData.characterName).scale(.5).draw(80, 115 + _row * (item_readout_px.y + item_readout_padding));
			
			var _healthPercent = (_partyMember.CombatData.HP / _partyMember.CombatData.maxHP) * 100;
			draw_healthbar(405, 120 + _row * (item_readout_px.y + item_readout_padding), 500, 135 + _row * (item_readout_px.y + item_readout_padding), _healthPercent, _partyMember.CharaData.healthColor.y, _partyMember.CharaData.healthColor.x, _partyMember.CharaData.healthColor.x, 0, true, false);
			if(sign(_healthPercent) = -1) // Draw the reverse healthbar if health is negative
				draw_healthbar(310, 120 + _row * (item_readout_px.y + item_readout_padding), 405, 135 + _row * (item_readout_px.y + item_readout_padding), abs(_healthPercent), _partyMember.CharaData.healthColor.y, _partyMember.CharaData.healthColor.x, _partyMember.CharaData.healthColor.x, 1, false, false);
			
			if(global.PartyArray[| chara_currently_selecting_action].thisTurnsSelectedPartyTarget == (_row + (_page * 3))) // Draw soul next to the hovered option
				draw_sprite(current_selector_icon, 0, 65, 130 + _row * (item_readout_px.y + item_readout_padding));
		}
		
		// Arrows to indicate other pages of characters
		if(_page > 0)
			draw_sprite_ext(spr_BattleRoom_Arrow, 0, 625, 130 - (abs(sin(item_readout_arrow_sinpulser / 8)) + 0.25) * 5, 1, 1, 180, c_white, 1);
			
		if(ds_list_size(global.PartyArray) > (_page + 1) * 3)
			draw_sprite_ext(spr_BattleRoom_Arrow, 0, 625, 190 + (abs(sin(item_readout_arrow_sinpulser / 8)) + 0.25) * 5, 1, 1, 0, c_white, 1);
		
		item_readout_arrow_sinpulser += .75;
		
		#endregion
	break;
	
}


#region Character Panels
// Draw the character panels
for (var i = 0; i < ds_list_size(global.PartyArray); ++i) {
    
	if(global.PartyArray[| i].CharaID != CHARACTERS.None)
	{
		var _currentEntry      = global.PartyArray[| i].CharaData;
		var _currentEntryCmbt  = global.PartyArray[| i].CombatData;
		var _charaPanelAnchorX = mainmenu_charapanels_draw[i].x;
		var _charaPanelAnchorY = global.PartyArray[| i].CharaData.characterPanelCurrentDrawY;
		var _ActionIconOffset  = (sprite_get_width(spr_BattleRoom_ActionButtonIcon_Item) + action_button_padding.x);
		
		// Draw buttons behind panels. Sidenote: holy if statement
		if(i == chara_currently_selecting_action)
		{
			
			#region That one effect behind the action icons
			
			// If there are less than a certian amount of the background cool line boxes
			if(wait(0.5) && ds_list_size(mainmenu_background_drawboxeseffect) < 3)
				ds_list_add(mainmenu_background_drawboxeseffect, new Vector2(104, 1));
			
			//Draw the background box effect
			if(!ds_list_empty(mainmenu_background_drawboxeseffect))
			{		
				draw_set_colour(_currentEntry.characterPanelExtColor);
				
				for (var d = 0; d < ds_list_size(mainmenu_background_drawboxeseffect); d++) {
					
					// Set alpha to the y value (using a vec2 to store the pos and alpha)
					draw_set_alpha(mainmenu_background_drawboxeseffect[| d].y)
					
					draw_line_width(_charaPanelAnchorX + mainmenu_background_drawboxeseffect[| d].x, mainmenu_charapanel_closed_y - (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2), _charaPanelAnchorX + mainmenu_background_drawboxeseffect[| d].x, mainmenu_charapanel_closed_y + (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2) - 2, mainmenu_charapanel_outlinethickness);
					draw_line_width(_charaPanelAnchorX - mainmenu_background_drawboxeseffect[| d].x, mainmenu_charapanel_closed_y - (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2), _charaPanelAnchorX - mainmenu_background_drawboxeseffect[| d].x, mainmenu_charapanel_closed_y + (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2) - 2, mainmenu_charapanel_outlinethickness);
					
					mainmenu_background_drawboxeseffect[| d].x -= 1;
					mainmenu_background_drawboxeseffect[| d].y -= .03;
				}
				
				// This has to run seperate of the main loop so it doesnt delete while running
				// The deletion while running isn't really a problem but it causes a minor, yet really annoying visual bug where the bars flicker
				for (var d = 0; d < ds_list_size(mainmenu_background_drawboxeseffect); d++) { 
					if(mainmenu_background_drawboxeseffect[| d].y <= .2)
						ds_list_delete(mainmenu_background_drawboxeseffect, d);
				}
			}
			
			// Reset draw stuff just to make sure
			draw_reset();
			
			#endregion
			
			#region Draw Icons
			if(currently_hovered_action == ACTION.ATTACK)
				draw_sprite(_currentEntry.characterActionIconAttack[1], 0, _charaPanelAnchorX - _ActionIconOffset * 2, mainmenu_charapanel_closed_y + action_button_padding.y);
			else
				draw_sprite(_currentEntry.characterActionIconAttack[0], 0, _charaPanelAnchorX - _ActionIconOffset * 2, mainmenu_charapanel_closed_y + action_button_padding.y);
			
			if(_currentEntry.characterUsesAct)
			{
				if(currently_hovered_action == ACTION.MAGICORACT)
					draw_sprite(_currentEntry.characterActionIconAct[1], 0, _charaPanelAnchorX - (sprite_get_width(spr_BattleRoom_ActionButtonIcon_Item) + action_button_padding.x), mainmenu_charapanel_closed_y + action_button_padding.y);
				else
					draw_sprite(_currentEntry.characterActionIconAct[0], 0, _charaPanelAnchorX - (sprite_get_width(spr_BattleRoom_ActionButtonIcon_Item) + action_button_padding.x), mainmenu_charapanel_closed_y + action_button_padding.y);
			}
			else
			{
				if(currently_hovered_action == ACTION.MAGICORACT)
					draw_sprite(_currentEntry.characterActionIconMagic[1], 0, _charaPanelAnchorX - (sprite_get_width(spr_BattleRoom_ActionButtonIcon_Item) + action_button_padding.x), mainmenu_charapanel_closed_y + action_button_padding.y);
				else
					draw_sprite(_currentEntry.characterActionIconMagic[0], 0, _charaPanelAnchorX - (sprite_get_width(spr_BattleRoom_ActionButtonIcon_Item) + action_button_padding.x), mainmenu_charapanel_closed_y + action_button_padding.y);
			}
			
			if(currently_hovered_action == ACTION.ITEM)
				draw_sprite(_currentEntry.characterActionIconItem[1],   0, _charaPanelAnchorX, mainmenu_charapanel_closed_y + action_button_padding.y);
			else
				draw_sprite(_currentEntry.characterActionIconItem[0],   0, _charaPanelAnchorX, mainmenu_charapanel_closed_y + action_button_padding.y);
				
			if(currently_hovered_action == ACTION.SPARE)
				draw_sprite(_currentEntry.characterActionIconSpare[1],  0, _charaPanelAnchorX + _ActionIconOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
			else
				draw_sprite(_currentEntry.characterActionIconSpare[0],   0, _charaPanelAnchorX + _ActionIconOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
				
			if(currently_hovered_action == ACTION.DEFEND)
				draw_sprite(_currentEntry.characterActionIconDefend[1], 0, _charaPanelAnchorX + _ActionIconOffset * 2, mainmenu_charapanel_closed_y + action_button_padding.y);
			else
				draw_sprite(_currentEntry.characterActionIconDefend[0],   0, _charaPanelAnchorX + _ActionIconOffset * 2, mainmenu_charapanel_closed_y + action_button_padding.y);
				
			#endregion
				
		}
		else if(_currentEntry.characterPanelState != CHARAPANELSTATE.CLOSED)
		{
			draw_sprite(_currentEntry.characterActionIconAttack[0], 0, _charaPanelAnchorX - _ActionIconOffset * 2, mainmenu_charapanel_closed_y + action_button_padding.y);
			
			if(_currentEntry.characterUsesAct)
				draw_sprite(_currentEntry.characterActionIconAct[0],   0, _charaPanelAnchorX - (sprite_get_width(spr_BattleRoom_ActionButtonIcon_Item) + action_button_padding.x), mainmenu_charapanel_closed_y + action_button_padding.y);
			else
				draw_sprite(_currentEntry.characterActionIconMagic[0], 0, _charaPanelAnchorX - (sprite_get_width(spr_BattleRoom_ActionButtonIcon_Item) + action_button_padding.x), mainmenu_charapanel_closed_y + action_button_padding.y);
				
			draw_sprite(_currentEntry.characterActionIconItem[0],   0, _charaPanelAnchorX, mainmenu_charapanel_closed_y + action_button_padding.y);
			draw_sprite(_currentEntry.characterActionIconSpare[0],  0, _charaPanelAnchorX + _ActionIconOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
			draw_sprite(_currentEntry.characterActionIconDefend[0], 0, _charaPanelAnchorX + _ActionIconOffset * 2, mainmenu_charapanel_closed_y + action_button_padding.y);
		}
		
		draw_sprite(_currentEntry.characterPanel, 0, _charaPanelAnchorX, _charaPanelAnchorY);
		draw_sprite(_currentEntry.characterIconCurrentRender,  0, _charaPanelAnchorX + _currentEntry.characterIconPortraitOffset.x, _charaPanelAnchorY +_currentEntry.characterIconPortraitOffset.y); // Needs to account for character injured later
		
		// Character HP and healthbar
		
		var _HPArray    = ConvertHPToSpriteArray(_currentEntryCmbt.HP);
		var _maxHPArray = ConvertHPToSpriteArray(_currentEntryCmbt.maxHP);
		var _drawColor  = c_white;
		
		if(_currentEntryCmbt.HP <= 0)
			_drawColor = c_red;
		
		// Read the array backwards since it is from right to left so that any number theoretically could work, even though it should probably never go above 999
		for (var j = array_length(_HPArray) - 1; j >= 0; j--) 
		{
		    draw_sprite_ext(_HPArray[j], 0, (_charaPanelAnchorX + HP_number_offset.x) - ((HP_number_padding.x + sprite_get_width(spr_HPNumber_Empty))*(array_length(_HPArray) - j - 1)), _charaPanelAnchorY + HP_number_offset.y, 1, 1, 0, _drawColor, 1);
		}
		
        // Same thing but for maxHP
		for (var j = array_length(_maxHPArray) - 1; j >= 0; j--) 
		{
		    draw_sprite_ext(_maxHPArray[j], 0, (_charaPanelAnchorX + maxHP_number_offset.x) - ((HP_number_padding.x + sprite_get_width(spr_HPNumber_Empty))*(array_length(_maxHPArray) - j - 1)), _charaPanelAnchorY + maxHP_number_offset.y,  1, 1, 0, _drawColor, 1);
		}
		
		// Draw Healthbar
		var _healthPercent = 0;
		
		if(_currentEntryCmbt.HP > 0)
			_healthPercent = (_currentEntryCmbt.HP / _currentEntryCmbt.maxHP) * 100;
		
		draw_healthbar(_charaPanelAnchorX + chara_healthbar_topleft.x, _charaPanelAnchorY + chara_healthbar_topleft.y, _charaPanelAnchorX + chara_healthbar_btmright.x, _charaPanelAnchorY + chara_healthbar_btmright.y, _healthPercent, chara_healthbar_bgcol, _currentEntry.characterPanelExtColor, _currentEntry.characterPanelExtColor, 0, true, false);
		
		// If this character is currently the one selecting their action
		if(i == chara_currently_selecting_action)
		{
			// If panel is CLOSED and this character is selected, begin OPENING 
			if(_currentEntry.characterPanelState == CHARAPANELSTATE.CLOSED)
				_currentEntry.characterPanelState = CHARAPANELSTATE.OPENING;
				
			// Draw the character panel outline
			draw_set_colour(_currentEntry.characterPanelExtColor);
			
			// Magic number shit but damn are they magical
			draw_line_width(_charaPanelAnchorX - 108, _charaPanelAnchorY - 19, _charaPanelAnchorX + 106, _charaPanelAnchorY - 19, 2);
			
			// Recreating a behavior from the base game. Said behavior is that the bottom outline of the character panel outline only appears when fully open. I think there is a difference because we render the character panels differently
			// I dont even know why I am recreating this. It doesn't matter and the pop-in is annoying.
			if(_currentEntry.characterPanelState == CHARAPANELSTATE.OPEN)
				draw_line_width(_charaPanelAnchorX - 108, _charaPanelAnchorY + 17, _charaPanelAnchorX + 106, _charaPanelAnchorY + 17, 2);
			
			// The two lines that drop to the main dialog box
			draw_line_width(_charaPanelAnchorX - 107, _charaPanelAnchorY - 19, _charaPanelAnchorX - 107, mainmenu_charapanel_closed_y + (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2) - 2, 2);
			draw_line_width(_charaPanelAnchorX + 105, _charaPanelAnchorY - 19, _charaPanelAnchorX + 105, mainmenu_charapanel_closed_y + (sprite_get_height(spr_BattleRoom_CharaPanel_Template) / 2) - 2, 2);
			
			draw_set_colour(c_white);
				
		}
		else
		{
			// Begin closing panel if open
			if(_currentEntry.characterPanelState == CHARAPANELSTATE.OPEN)
				_currentEntry.characterPanelState = CHARAPANELSTATE.CLOSING;
			
		}
		
		
		
	}
}
#endregion

// Reset draw target
surface_reset_target();
draw_surface(surface_mainmenu, surface_mainmenu_draw.x, surface_mainmenu_draw.y);

#endregion
}