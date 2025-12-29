function MainMenuSlideIn()
{
	if(!global.MainMenuSlideIn && !global.MainMenuSlideOut)
		global.MainMenuSlideIn = true;
}

function MainMenuSlideOut()
{
	if(!global.MainMenuSlideIn && !global.MainMenuSlideOut)
		global.MainMenuSlideOut = true;
}

function MainMenuIsIn()
{
	if(global.BattleController != -1)
	{
		if(global.BattleController.surface_mainmenu_draw.y == 260)
			return true;		
	}
	return false;
}

function MainMenuIsOut()
{
	if(global.BattleController != -1)
	{
		if(global.BattleController.surface_mainmenu_draw.y == 490)
			return true;		
	}
	return false;
}