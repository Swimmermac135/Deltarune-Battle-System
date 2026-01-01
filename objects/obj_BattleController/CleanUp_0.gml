if(surface_exists(surface_TPmeter))
	surface_free(surface_TPmeter);

if (surface_exists(surface_mainmenu))
	surface_free(surface_mainmenu);

ds_list_destroy(character_animations_complete);
ds_list_destroy(mainmenu_background_drawboxeseffect);

if(ds_exists(global.PartyArray , ds_type_list))
	ds_list_clear(global.PartyArray);
	
if(ds_exists(global.EnemyArray , ds_type_list))
	ds_list_clear(global.EnemyArray);
