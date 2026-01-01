function StartCombat(_partyArray, _enemyArray, _skipIntro, _offsetDrawForTwoMembers = false){
	
	// Clear out any stragglers. This is also done on battle complete and on battlecontroller cleanup
	if(ds_exists(global.PartyArray , ds_type_list))
		ds_list_clear(global.PartyArray);
	
	if(ds_exists(global.EnemyArray , ds_type_list))
		ds_list_clear(global.EnemyArray);
	
	global.EnemyArrayIndexes = _enemyArray;
	global.PartyArrayIndexes = _partyArray;
	global.BattleSkipIntro   = _skipIntro;
	global.OffsetPartyDraw   = _offsetDrawForTwoMembers;
	
	if(!instance_exists(obj_BattleController))
		global.BattleController = instance_create_depth(0, 0, 0, obj_BattleController);
	
	global.BattleState = BATTLESTATE.LOAD;
}