
#region Tension Meter

//Create render target surface if it doesn't exist yet
if (!surface_exists(surface_TPmeter))
{
    surface_TPmeter = surface_create(96, 240);
	//show_debug_message("Created TP Meter Surface")
}

//Set render target to correct surface and clear the surface.
surface_set_target(surface_TPmeter);
draw_clear_alpha(c_black, 0);

// Draw Meter Background
draw_sprite_ext(tensionmeter_spr_background, 0, tensionmeter_mainmeter_draw.x, tensionmeter_mainmeter_draw.y, 1, 1, 0, c_white, 1);

var DrawMeterOffsetFromMaxY = (tension_percent * tensionmeter_height);
var DrawCostOffsetFromMaxY  = clamp((((global.TP - global.TensionHovered) / global.MaxTP) * tensionmeter_height),0,200);
var DrawFalseOffsetFromMaxY = (false_tension_percent * tensionmeter_height);

// Draw Meter
if(floor((global.TP / global.MaxTP) * 100) == global.MaxTP)
	draw_set_colour(merge_colour(c_yellow, c_orange, 0.5));
else
	draw_set_colour(c_orange);

draw_rectangle(tensionmeter_rect_topleft.x, tensionmeter_rect_btmright.y - DrawMeterOffsetFromMaxY, tensionmeter_rect_btmright.x, tensionmeter_rect_btmright.y, false);
draw_set_colour(c_white);

//Draw the change meter 
if(false_TP != global.TP)
{
	if(false_TP > global.TP)
		draw_set_colour(c_red);
	else
		draw_set_colour(c_white);
		
	draw_rectangle(tensionmeter_rect_topleft.x, tensionmeter_rect_btmright.y - DrawFalseOffsetFromMaxY, tensionmeter_rect_btmright.x, tensionmeter_rect_btmright.y - DrawMeterOffsetFromMaxY, false);
}


//Draw the Hovered Cost Meter
if(global.TensionHovered > 0)
{
	draw_set_colour(c_white);
	draw_set_alpha(abs(sin(tensionmeter_alpha_pulser / 8) * 0.5) + 0.25);
	
	if(global.TensionHovered > global.TP)
	{
		// Can't Afford
		draw_set_colour(c_dkgray);
		draw_set_alpha(0.7);
	}
	tensionmeter_alpha_pulser++;

	draw_rectangle(tensionmeter_rect_topleft.x, tensionmeter_rect_btmright.y - DrawMeterOffsetFromMaxY, tensionmeter_rect_btmright.x, tensionmeter_rect_btmright.y - DrawCostOffsetFromMaxY, false);
}
draw_set_alpha(1);

// Draw Marker
if(global.TP > 0 && global.TP < global.MaxTP)
	draw_sprite(tensionmeter_spr_tension_marker, 0, tensionmeter_mainmeter_draw.x, tensionmeter_rect_btmright.y - DrawMeterOffsetFromMaxY);

// Draw Meter Outline
draw_sprite_ext(tensionmeter_spr_outline, 0, tensionmeter_mainmeter_draw.x, tensionmeter_mainmeter_draw.y, 1, 1, 0, c_white, 1);

// Draw Meter Cutout
gpu_set_blendmode(bm_subtract);
draw_sprite_ext(tensionmeter_spr_cutout,  0, tensionmeter_mainmeter_draw.x, tensionmeter_mainmeter_draw.y, 1, 1, 0, c_white, 1);
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_src_alpha, bm_one); // Thank you random redditor for this fix, the "update" bars (add/subtract/cost) kept setting the transparency weird.

draw_sprite_ext(tensionmeter_spr_TPicon,  0, tensionmeter_TPicon_draw.x,    tensionmeter_TPicon_draw.y,    1, 1, 0, c_white, 1);

if(floor((global.TP / global.MaxTP) * 100) < global.MaxTP)
{
	scribble($"{floor((global.TP / global.MaxTP) * 100)}").scale(.5).draw(tensionmeter_text_draw.x, tensionmeter_text_draw.y);
	scribble("%").scale(.5).draw(tensionmeter_pcnt_draw.x, tensionmeter_pcnt_draw.y);
}
else
{
	scribble("M").scale(.5).blend(c_yellow, 1).draw(tensionmeter_text_draw.x,     tensionmeter_text_draw.y);
	scribble("A").scale(.5).blend(c_yellow, 1).draw(tensionmeter_text_draw.x + 4, tensionmeter_text_draw.y + 20); 
	scribble("X").scale(.5).blend(c_yellow, 1).draw(tensionmeter_text_draw.x + 8, tensionmeter_text_draw.y + 40); 
}

surface_reset_target();
draw_surface(surface_TPmeter, surface_TPmeter_draw.x, surface_TPmeter_draw.y);

#endregion