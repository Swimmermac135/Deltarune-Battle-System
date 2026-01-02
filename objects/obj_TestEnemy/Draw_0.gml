draw_self();

if(flash)
{
	shader_set(shd_Flash);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, abs(sin(alpha_pulser / 8) * 0.5) + 0.25);
	shader_reset();
	
	alpha_pulser++;
}