#region ENUMs

enum BATTLESTATE
{
	AWAIT, // Shouldnt be used normally, only used to wait for starting battles in the testing environment
	
	LOAD,           // Battle Setup (Creating the Render Puppet objs)
	CHARACTERINTRO, // The little flourish at the beginning
	BATTLESTART,	// Final setup and battle element load ins (menu and TP bar)
	
	// Player's Turn
	PLAYERSELECTING,
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

enum CHARAPANELSTATE
{
	CLOSED,
	OPENING,
	OPEN,
	CLOSING
}

enum ACTION
{
	UNDECIDED,
	ATTACK,
	MAGICORACT,
	ITEM,
	SPARE,
	DEFEND,
}

enum MAINMENUSTATE
{
	SELECTINGMAINACTION, // Player is selecting from main action list
	SELECTINGATTACKTARGET,
	SELECTINGACTTARGET,
	SELECTINGMAGICTARGET,
	
	SELECTINGITEM,
	ITEMSELECTPARTYMEMBER,
	
	SELECTINGSPARETARGET,
	SHOWINGTYPEWRITER,   // Basically if there is text being shown
	

}

#endregion

global.BattleState = BATTLESTATE.AWAIT;

global.BattleController = -1;

#region Render Puppet

if(global.LargePartyMode)
{
	// Not Implemented
	chara_renderpuppet_preset_locations = [new Vector2(80, 125), new Vector2(40, 215), new Vector2(70, 315), new Vector2(80, 125), new Vector2(40, 215), new Vector2(70, 315)]; 
	enemy_renderpuppet_preset_locations = [new Vector2(550, 65), new Vector2(550, 165), new Vector2(550, 265), new Vector2(550, 65), new Vector2(550, 165), new Vector2(550, 265)];
}
else // This should adapt based on the amount of party members/enemies. If one, render in the middle. If two, use offset. etc
{
	chara_renderpuppet_preset_locations = [new Vector2(80, 125), new Vector2(40, 215), new Vector2(70, 315)];
	enemy_renderpuppet_preset_locations = [new Vector2(550, 65), new Vector2(550, 165), new Vector2(550, 265)]
}
chara_renderpuppet_setup_complete = false;
enemy_setup_complete = false;



// the things I do for this one specific feature that all it does is make one animation look nice
character_animations_complete = ds_list_create(); 

#endregion

#region Tension Meter Variables

/* Variables are all stored here to both avoid magic numbers and so I can change them later mid-fight if I want to. I don't have any plans for it but the option is there */

global.TPMeterSlideIn  = false;
global.TPMeterSlideOut = false;

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

// Colors
tensionmeter_color_increase	    = c_white;
tensionmeter_color_decrease		= c_red;
tensionmeter_color_hover        = c_white;
tensionmeter_color_cannotafford = c_gray;
tensionmeter_color_main			= c_orange;
tensionmeter_color_maxxed		= merge_colour(c_yellow, c_orange, 0.5);
tensionmeter_color_maxtextcol   = c_yellow;


#endregion

#region Main Menu Variables

global.MainMenuSlideIn  = false;
global.MainMenuSlideOut = false;

// what is the menu currently doing
main_menu_phase = MAINMENUSTATE.SELECTINGMAINACTION;

// Set up variable for the main menu to be drawn to
surface_mainmenu = -1;

// Manipulate this to change the entire menu's position
surface_mainmenu_draw = new Vector2(0, 490);

// Draw position for the background
//mainmenu_background_draw = new Vector2(320, 142);

// Y positions for closed and open tabs
mainmenu_charapanel_closed_y = 85; 
mainmenu_charapanel_open_y   = 51;

// Thickness of panel outline
mainmenu_charapanel_outlinethickness = 2;

// Positions for action icons [Removed in favor of using bounding box allignments]
//mainmenu_charapanel_actionicon_x = 0;

// Variables for that one background box fading effect on the selected character
// [x offset from anchor, opacity]. Actually just use vector2 for this
mainmenu_background_drawboxeseffect = ds_list_create();

// X positions for closed character tabs.
// This should be refactored to be set by the battle start script
if(global.LargePartyMode)
{
	// Not Implemented
	mainmenu_charapanels_draw = [new Vector2(108, mainmenu_charapanel_closed_y), new Vector2(320, mainmenu_charapanel_closed_y), new Vector2(532, mainmenu_charapanel_closed_y)];
}
else if(array_length(global.PartyArrayIndexes) == 2 && global.OffsetPartyDraw) // This is stupid
{
	mainmenu_charapanels_draw = [new Vector2(210, mainmenu_charapanel_closed_y), new Vector2(430, mainmenu_charapanel_closed_y)];
	show_debug_message("Loaded Offset Menu Coords")
}
else
	mainmenu_charapanels_draw = [new Vector2(108, mainmenu_charapanel_closed_y), new Vector2(320, mainmenu_charapanel_closed_y), new Vector2(532, mainmenu_charapanel_closed_y)];

// Who is currently selecting their action
chara_currently_selecting_action = 0;

// What action is currently selected
currently_hovered_action = ACTION.ATTACK;

// Artificial delay between menu transitions to stop multiselecting
menu_swap_delay = 0

// Enemy/ally name render position
mainmenu_selectortext_position = [new Vector2(65, 115)];
current_selector_icon          = spr_BattleRoom_RedSoul;

action_button_padding = new Vector2(5, 3);

// HP bar offsets
HP_number_offset    = new Vector2(48, -6);
maxHP_number_offset = new Vector2(93, -6);
HP_number_padding   = new Vector2(2, 0);

chara_healthbar_bgcol    = #7F080C;
chara_healthbar_topleft  = new Vector2(21, 2);
chara_healthbar_btmright = new Vector2(96, 10);

// Item readout padding test
item_readout_px = new Vector2(210, 20);
item_readout_padding = 10;

item_readout_arrow_sinpulser = 0; // This will probably be used for a lot, not just arrow sinpulse

// Character readout

// Sprites
//mainmenu_spr_background = spr_BattleRoom_MainMenu_Background;

// Colors
mainmenu_col_linework   = $332033;
mainmenu_col_background = c_black; 

#endregion