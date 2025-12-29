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


// Draw the character panels
for (var i = 0; i < ds_list_size(global.PartyArray); ++i) {
    
	if(global.PartyArray[| i].CharaID != CHARACTERS.None)
	{
		var _currentEntry = global.PartyArray[| i].CharaData;
		var _charaPanelAnchorX = mainmenu_charapanels_draw[i].x;
		var _charaPanelAnchorY = global.PartyArray[| i].CharaData.characterPanelCurrentDrawY;
		
		draw_sprite(_currentEntry.characterPanel, 0, _charaPanelAnchorX, _charaPanelAnchorY);
		draw_sprite(_currentEntry.characterIcon,  0, _charaPanelAnchorX + _currentEntry.characterIconPortraitOffset.x, _charaPanelAnchorY +_currentEntry.characterIconPortraitOffset.y); // Needs to account for character injured later
		
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

// Reset draw target
surface_reset_target();
draw_surface(surface_mainmenu, surface_mainmenu_draw.x, surface_mainmenu_draw.y);

#endregion
}