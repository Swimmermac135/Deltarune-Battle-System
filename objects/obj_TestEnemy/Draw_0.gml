draw_self();

if(flash)
{
	shader_set(shd_Flash);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, abs(sin(alpha_pulser / 10)));
	shader_reset();
	
	alpha_pulser++;
}