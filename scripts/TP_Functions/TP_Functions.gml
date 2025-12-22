function SetTP(target){
	
	global.TP = clamp(target, 0, global.MaxTP);

}

function AddTP(num){
	
	global.TP = clamp(global.TP + num, 0, global.MaxTP);
	
}

function RemoveTP(num){
	
	global.TP = clamp(global.TP - num, 0, global.MaxTP);
	
}