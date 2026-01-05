if (global.DebugMode)
	draw_text(10, 10, "FPS = " + string(fps));

#region Quitting Game

	if(time_spent_holding_escape > 0)
	{
		var DrawPhase = 0;
		
		if(time_spent_holding_escape > 10)
			DrawPhase = 1;
		if(time_spent_holding_escape > 25)
			DrawPhase = 2;
		if(time_spent_holding_escape > 40)
			DrawPhase = 3;
		if(time_spent_holding_escape > 55)
			DrawPhase = 4;
	
		draw_sprite_ext(spr_QuittingText, DrawPhase, 0, 0, 2, 2, 0, c_white, 1);
	}

#endregion