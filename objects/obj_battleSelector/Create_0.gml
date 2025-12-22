/// @description Vars Setup
enum SELECTMENUSTATE
{
	SELECTING,
	CONFIRMING
}

current_menu_state = SELECTMENUSTATE.SELECTING;
is_confirm_selected = true;


current_list_offset = 0;
currently_selected_entry = 1;
//num_pages = ceil(ds_list_size(global.available_combat_encounters) / 3);
current_page = 0;

selector_box_1_y_coordinate = 170;
selector_box_2_y_coordinate = 250;
selector_box_3_y_coordinate = 330;

selector_box_x_coordinate = 320;