//Destroy stuff in memory
ds_list_destroy(global.AvailableCombatEncounters);

ds_list_destroy(global.PartyArray);
ds_list_destroy(global.EnemyArray);

ds_map_destroy(global.CharacterCombatRefMap);
ds_map_destroy(global.EnemyMap);
ds_map_destroy(global.CharacterRefMap);
ds_map_destroy(global.ItemMap);
