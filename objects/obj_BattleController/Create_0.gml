#region ENUMs

enum BATTLESTATE
{
	LOAD,           // Battle Setup (Creating the Render Puppet objs)
	CHARACTERINTRO, // The little flourish at the beginning
	BATTLESTART,	// Final setup and battle element load ins (menu and TP bar)
	
	// Player's Turn
	SELECT,
	ACT,
	FIGHT,
	ITEM,
	// Animations during battlebox phase in part (In between player turn and enemy turn)
	PLAYERTOENEMYTRANSITION,
	// Animations during battlebox phase out part (In between enemy turn and player turn)
	ENEMYTOPLAYERTRANSITION,
	
	//End of battle animation
	BATTLEEND
}

#endregion

global.BattleState = BATTLESTATE.LOAD;

global.BattleController = -1;

character_animations_complete = ds_list_create(); // the things I do for this one specific feature that all it does is make one animation look nice
timer = 0;
//show_debug_message(CharaData_From_CharaID(party_array[0]));

#region Render Puppet

if(global.LargePartyMode)
{
	// Not Implemented
	chara_renderpuppet_preset_locations = []; 
	enemy_renderpuppet_preset_locations = [];
}
else
{
	chara_renderpuppet_preset_locations = [new Vector2(80, 45), new Vector2(40, 135), new Vector2(70, 225)];
	enemy_renderpuppet_preset_locations = [new Vector2(550, 65), new Vector2(550, 165), new Vector2(550, 265)]
}
chara_renderpuppet_setup_complete = false;
enemy_renderpuppet_setup_complete = true;

#endregion

#region Tension Meter Variables

/* Variables are all stored here to both avoid magic numbers and so I can change them later mid-fight if I want to. I don't have any plans for it but the option is there */

// Set up variable for the TP meter to be drawn to
surface_TPmeter = -1;

// Manipulate this to change the entire meters position
surface_TPmeter_draw = new Vector2(-90, 0);

global.TP             = 0;   // Actual TP
global.MaxTP          = 100; // Max TP
global.TensionHovered = 0;   // Cost of selected ACT/MAGIC

false_TP = global.TP;
false_TP_update = 0;

// How full is the tension meter
tension_percent       = global.TP / global.MaxTP;
false_tension_percent = false_TP / global.MaxTP;

// Position to draw the meter in
tensionmeter_mainmeter_draw = new Vector2(50, 140);

// Position to draw the TP icon
tensionmeter_TPicon_draw    = new Vector2(19, 92);

// Draw location for the text/numbers
tensionmeter_text_draw      = new Vector2(6, 110);

// Draw location for the percent sign
tensionmeter_pcnt_draw      = new Vector2(11, 135);

// Draw locations for the main meter draw_rectangle
tensionmeter_rect_topleft   = new Vector2(40, 47);
tensionmeter_rect_btmright  = new Vector2(60, 234);

// How large is the main TP bar in px
tensionmeter_height	= 187;

// Var for making opacity do the cool shimmer thing
tensionmeter_alpha_pulser = 0;

// Sprites (Base game uses the redfill when the bar decreases and the whitefill for increases)
tensionmeter_spr_outline        = spr_BattleRoom_TensionMeter_MeterOutline
tensionmeter_spr_background     = spr_BattleRoom_TensionMeter_MeterBackground;
tensionmeter_spr_cutout         = spr_BattleRoom_TensionMeter_MeterCutout;
tensionmeter_spr_tension_marker = spr_BattleRoom_TensionMeter_TensionMarker;
tensionmeter_spr_TPicon	        = spr_BattleRoom_TensionMeter_TPIcon;

//Colors
tensionmeter_color_increase	    = c_white;
tensionmeter_color_decrease		= c_red;
tensionmeter_color_hover        = c_white;
tensionmeter_color_cannotafford = c_white;
tensionmeter_color_main			= c_orange;
tensionmeter_color_maxxed		= merge_colour(c_yellow, c_orange, 0.5);
tensionmeter_color_maxtextcol   = c_yellow;

#endregion

#region Main Menu Variables

// Set up variable for the TP meter to be drawn to
surface_mainmenu = -1;

// Manipulate this to change the entire meters position
surface_mainmenu_draw = new Vector2(, 0);

#endregion