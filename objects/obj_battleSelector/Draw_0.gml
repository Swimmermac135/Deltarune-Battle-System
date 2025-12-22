#region Draw the boxes

var NumChoicesOnPage = ds_list_size(global.AvailableCombatEncounters) - (current_page * 3);
var SelectedSlot = currently_selected_entry - (current_page * 3);
var TextDrawOffset = 10;

if(NumChoicesOnPage >= 1)
{
	var S1TextDrawColor = $00A600
	if(current_menu_state == SELECTMENUSTATE.SELECTING || (current_menu_state == SELECTMENUSTATE.CONFIRMING && SelectedSlot != 1))
	{
		if(SelectedSlot == 1)
		{
			S1TextDrawColor = $00FF00
			draw_sprite_ext(spr_BattleSelectMenuOptionSelected, 0, selector_box_x_coordinate, selector_box_1_y_coordinate, 1.3, 1, 0, c_white, 1);
		}
		else
			draw_sprite_ext(spr_BattleSelectMenuOption, 0, selector_box_x_coordinate, selector_box_1_y_coordinate, 1.3, 1, 0, c_white, 1);
	
		scribble(global.AvailableCombatEncounters[| (current_page * 3)].displayName).scale(.25).blend(S1TextDrawColor,1).draw(185,150);
		scribble(global.AvailableCombatEncounters[| (current_page * 3)].displayInfo).scale(.25).blend(S1TextDrawColor,1).draw(185,175);
		scribble(global.AvailableCombatEncounters[| (current_page * 3)].displayLevel).scale(.25).blend(S1TextDrawColor,1).draw(325,150);
	
		//Load Star Data Here
	}
	else
	{
		S3TextDrawColor = $00FF00
		draw_sprite_ext(spr_BattleSelectMenuOptionChoicer, 0, selector_box_x_coordinate, selector_box_1_y_coordinate, 1.3, 1, 0, c_white, 1);
		
		scribble("Confirm").scale(.25).blend(S3TextDrawColor,1).draw(200,selector_box_1_y_coordinate - TextDrawOffset);
		scribble("Go Back").scale(.25).blend(S3TextDrawColor,1).draw(380,selector_box_1_y_coordinate - TextDrawOffset);
		
		if(is_confirm_selected)
			draw_sprite(spr_BattleSelectMenuSoul, 0, 180, selector_box_1_y_coordinate);
		else
			draw_sprite(spr_BattleSelectMenuSoul, 0, 360, selector_box_1_y_coordinate);
	}
}

if(NumChoicesOnPage >= 2)
{
	var S2TextDrawColor = $00A600
	if(current_menu_state == SELECTMENUSTATE.SELECTING || (current_menu_state == SELECTMENUSTATE.CONFIRMING && SelectedSlot != 2))
	{
		if(SelectedSlot == 2)
		{
			S2TextDrawColor = $00FF00
			draw_sprite_ext(spr_BattleSelectMenuOptionSelected, 0, selector_box_x_coordinate, selector_box_2_y_coordinate, 1.3, 1, 0, c_white, 1);
		}
		else
			draw_sprite_ext(spr_BattleSelectMenuOption, 0, selector_box_x_coordinate, selector_box_2_y_coordinate, 1.3, 1, 0, c_white, 1);
	
		scribble(global.AvailableCombatEncounters[| (current_page * 3) + 1].displayName).scale(.25).blend(S2TextDrawColor,1).draw(185,230);
		scribble(global.AvailableCombatEncounters[| (current_page * 3) + 1].displayInfo).scale(.25).blend(S2TextDrawColor,1).draw(185,255);
		scribble(global.AvailableCombatEncounters[| (current_page * 3) + 1].displayLevel).scale(.25).blend(S2TextDrawColor,1).draw(325,230);
	}
	else
	{
		S3TextDrawColor = $00FF00
		
		draw_sprite_ext(spr_BattleSelectMenuOptionChoicer, 0, selector_box_x_coordinate, selector_box_2_y_coordinate, 1.3, 1, 0, c_white, 1);
		
		scribble("Confirm").scale(.25).blend(S3TextDrawColor,1).draw(200,selector_box_2_y_coordinate - TextDrawOffset);
		scribble("Go Back").scale(.25).blend(S3TextDrawColor,1).draw(380,selector_box_2_y_coordinate - TextDrawOffset);
		
		if(is_confirm_selected)
			draw_sprite(spr_BattleSelectMenuSoul, 0, 180, selector_box_2_y_coordinate);
		else
			draw_sprite(spr_BattleSelectMenuSoul, 0, 360, selector_box_2_y_coordinate);
	}
}

if(NumChoicesOnPage >= 3)
{
	var S3TextDrawColor = $00A600
	if(current_menu_state == SELECTMENUSTATE.SELECTING || (current_menu_state == SELECTMENUSTATE.CONFIRMING && SelectedSlot != 3))
	{
		if(SelectedSlot == 3)
		{
			S3TextDrawColor = $00FF00
			draw_sprite_ext(spr_BattleSelectMenuOptionSelected, 0, selector_box_x_coordinate, selector_box_3_y_coordinate, 1.3, 1, 0, c_white, 1);
		}
		else
			draw_sprite_ext(spr_BattleSelectMenuOption, 0, selector_box_x_coordinate, selector_box_3_y_coordinate, 1.3, 1, 0, c_white, 1);

		scribble(global.AvailableCombatEncounters[| (current_page * 3) + 2].displayName).scale(.25).blend(S3TextDrawColor,1).draw(185,310);
		scribble(global.AvailableCombatEncounters[| (current_page * 3) + 2].displayInfo).scale(.25).blend(S3TextDrawColor,1).draw(185,335);
		scribble(global.AvailableCombatEncounters[| (current_page * 3) + 2].displayLevel).scale(.25).blend(S3TextDrawColor,1).draw(325,310);
	}
	else
	{
		S3TextDrawColor = $00FF00
		draw_sprite_ext(spr_BattleSelectMenuOptionChoicer, 0, selector_box_x_coordinate, selector_box_3_y_coordinate, 1.3, 1, 0, c_white, 1);
		
		scribble("Confirm").scale(.25).blend(S3TextDrawColor,1).draw(200,selector_box_3_y_coordinate - TextDrawOffset);
		scribble("Go Back").scale(.25).blend(S3TextDrawColor,1).draw(380,selector_box_3_y_coordinate - TextDrawOffset);
		
		if(is_confirm_selected)
			draw_sprite(spr_BattleSelectMenuSoul, 0, 180, selector_box_3_y_coordinate);
		else
			draw_sprite(spr_BattleSelectMenuSoul, 0, 360, selector_box_3_y_coordinate);
	}
}

#endregion

#region Draw the indicators of other pages

	if(current_page > 0)
	{
		draw_sprite_ext(spr_BattleSelectMenuPointer, 0, 510, 125, 1, 1, 0, c_white, 1);
	}
	
	if(ds_list_size(global.AvailableCombatEncounters) > (current_page + 1) * 3)
	{
		draw_sprite_ext(spr_BattleSelectMenuPointer, 0, 510, 380, 1, 1, 180, c_white, 1);
	}

#endregion