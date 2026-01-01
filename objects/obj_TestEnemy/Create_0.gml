HP = 1000;
max_HP = HP;
can_be_attacked = true;
can_be_acted    = true;
can_be_spared   = true;

health_percent_unknown = false;

displayName = "Blue Box";

checkDialog  = "Actually, it seems quite purple to me.";

attack  = 10;
defence = 10;

mercy_color  = new Vector2(c_yellow, #FF5021);
health_color = new Vector2(c_lime,   #7F080C);

mercy_text_color  = #660709;
health_text_color = c_white;

spare_percent = 0; // 0 to 100

// Enemy needs name, acts, description, attack and defence, 
// Acts can be stored in a ds grid or 2d array, with a name and execution script as well as stats

render_offset = new Vector2();