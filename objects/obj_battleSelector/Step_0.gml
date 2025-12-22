/// @description Change selected
if(InputPressed(INPUT_VERB.UP) && current_menu_state == SELECTMENUSTATE.SELECTING)
{
	if(currently_selected_entry > 1)
	{
		currently_selected_entry--;
		audio_play_sound(snd_UTDRSqueak,1,0);
	}
}

if(InputPressed(INPUT_VERB.DOWN) && current_menu_state == SELECTMENUSTATE.SELECTING)
{
	if(currently_selected_entry < ds_list_size(global.AvailableCombatEncounters))
	{
		currently_selected_entry++;
		audio_play_sound(snd_UTDRSqueak,1,0);
	}
}

if(InputPressed(INPUT_VERB.ACCEPT))
{
	audio_play_sound(snd_UTDRSelect,1,0);
			
	if(current_menu_state == SELECTMENUSTATE.CONFIRMING)
	{
		if(is_confirm_selected)
			script_execute(global.AvailableCombatEncounters[| currently_selected_entry - 1].startScript);
		else
			current_menu_state = SELECTMENUSTATE.SELECTING;
	}
	else if(current_menu_state == SELECTMENUSTATE.SELECTING)
	{
		current_menu_state = SELECTMENUSTATE.CONFIRMING
		is_confirm_selected = true;	
	}
}

if(InputPressed(INPUT_VERB.LEFT) && current_menu_state == SELECTMENUSTATE.CONFIRMING)
{
	is_confirm_selected = !is_confirm_selected;
	audio_play_sound(snd_UTDRSqueak,1,0);
}

if(InputPressed(INPUT_VERB.RIGHT) && current_menu_state == SELECTMENUSTATE.CONFIRMING)
{
	is_confirm_selected = !is_confirm_selected;
	audio_play_sound(snd_UTDRSqueak,1,0);
}

current_page = floor((currently_selected_entry - 1) / 3);

