draw_set_font(!mercy ? global.battleFont[1] : global.battleFont[2]);

draw_set_halign(fa_middle);
draw_set_valign(fa_center);

if !mercy
{
	if ind != -1 { draw_set_color(global.partyColour[ind]); }
	else { draw_set_color(c_lime); }
}

draw_set_alpha(image_alpha);
draw_text_transformed(x, y, msg, image_xscale, image_yscale, 0);
draw_set_alpha(1);

draw_set_color(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);