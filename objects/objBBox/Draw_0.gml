if image_alpha != 0
{
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, fadeAngle, c_white, 1);
	for (var i = 0; i < array_length(prevAngle); i++)
	{ draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, prevAngle[i], c_white, 0.2); }
}

draw_self();

draw_surface_part_ext(global.battleSurface,
	bbox_left, bbox_top, sprite_width - 2, sprite_height - 2, x - sprite_width/2 + 1, y - sprite_height/2 + 1,
		1, 1, c_white, 1);

surface_set_target(global.battleSurface);
draw_clear_alpha(c_black, 0);
surface_reset_target();