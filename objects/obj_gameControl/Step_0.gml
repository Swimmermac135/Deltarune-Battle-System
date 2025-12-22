#region Quit Game

	if(keyboard_check(vk_escape))
		time_spent_holding_escape++;
	else
		time_spent_holding_escape = 0;
	
	if(time_spent_holding_escape > 60)
		game_end();
	
#endregion