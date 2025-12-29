function SetTP(target){
	
	global.TP = clamp(target, 0, global.MaxTP);

}

function AddTP(num){
	
	global.TP = clamp(global.TP + num, 0, global.MaxTP);
	
}

function RemoveTP(num){
	
	global.TP = clamp(global.TP - num, 0, global.MaxTP);
	
}

function TPMeterSlideIn()
{
	if(!global.TPMeterSlideIn && !global.TPMeterSlideOut)
		global.TPMeterSlideIn = true;
}

function TPMeterSlideOut()
{
	if(!global.TPMeterSlideIn && !global.TPMeterSlideOut)
		global.TPMeterSlideOut = true;
}

function TPMeterIsIn()
{
	if(global.BattleController != -1)
	{
		if(global.BattleController.surface_TPmeter_draw.x == 0)
			return true;		
	}
	return false;
}

function TPMeterIsOut()
{
	if(global.BattleController != -1)
	{
		if(global.BattleController.surface_TPmeter_draw.x == -90)
			return true;		
	}
	return false;
}