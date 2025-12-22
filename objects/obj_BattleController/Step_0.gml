if(global.BattleController == -1) //Might remove this later
	global.BattleController = self;

#region Tension Meter

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
	
#endregion

//DEBUG
if(InputCheck(INPUT_VERB.ACCEPT))
	AddTP(1);
	
if(InputCheck(INPUT_VERB.CANCEL))
	RemoveTP(1);
	
if(InputCheck(INPUT_VERB.DOWN))
	SetTP(string_digits(get_string("Set TP","")));