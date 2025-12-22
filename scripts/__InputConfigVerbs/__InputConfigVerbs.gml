function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        UP,
        DOWN,
        LEFT,
        RIGHT,
		
		ABILITY1, // Special Ability "Your Power"
		ABILITY2, // Ability One
		
        ACCEPT, // For menus and dialog
        CANCEL,
        //ACTION,
        SPECIAL,
		
        PAUSE,
    }
    
    enum INPUT_CLUSTER
    {
        NAVIGATION,
    }
    
    if (not INPUT_ON_SWITCH)
    {
        InputDefineVerb(INPUT_VERB.UP,        "up",         [vk_up,    "W"],    [-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,      "down",       [vk_down,  "S"],    [ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,      "left",       [vk_left,  "A"],    [-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,     "right",      [vk_right, "D"],    [ gp_axislh, gp_padr]);
		InputDefineVerb(INPUT_VERB.ABILITY1,  "ability1",   "Q",                  gp_shoulderl);
		InputDefineVerb(INPUT_VERB.ABILITY2,  "ability2",   "E",                  gp_shoulderr);
		
        InputDefineVerb(INPUT_VERB.ACCEPT,    "accept",     [vk_enter, "Z"],        gp_face1);
        InputDefineVerb(INPUT_VERB.CANCEL,    "cancel",     [vk_control, "X"],      gp_face2);
		
       // InputDefineVerb(INPUT_VERB.ACTION,  "action",     vk_enter,            gp_face3);
        InputDefineVerb(INPUT_VERB.SPECIAL,   "special",    vk_shift,             gp_face4);
        InputDefineVerb(INPUT_VERB.PAUSE,     "pause",      vk_escape,            gp_start);
    }
    else //Flip A/B over on Switch
    {
        InputDefineVerb(INPUT_VERB.UP,        "up",         undefined, [-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,      "down",       undefined, [ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,      "left",		undefined, [-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,     "right",		undefined, [ gp_axislh, gp_padr]);
		InputDefineVerb(INPUT_VERB.ABILITY1,  "ability1",	undefined,   gp_shoulderl);
		InputDefineVerb(INPUT_VERB.ABILITY2,  "ability2",	undefined,   gp_shoulderr);
		InputDefineVerb(INPUT_VERB.ACCEPT,    "accept",     undefined,   gp_face2); // !!
		InputDefineVerb(INPUT_VERB.CANCEL,    "cancel",     undefined,   gp_face1); // !!
       // InputDefineVerb(INPUT_VERB.ACTION,  "action",  undefined,   gp_face3);
        InputDefineVerb(INPUT_VERB.SPECIAL,   "special", undefined,   gp_face4);
        InputDefineVerb(INPUT_VERB.PAUSE,     "pause",   undefined,   gp_start);
    }
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}
