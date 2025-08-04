draw_sprite_ext(sprBTPBar, 0, 36, 119, 0.5, 0.5, 0, c_white, 1);
draw_sprite_ext(sprBTPBar, 2, 36, 119, 0.5, 0.5*(whiteTP/100), 0, c_white, alpha);

var orangeLen = (orangeTP-highlightAmount)/100;
orangeLen = clamp(orangeLen, 0, 1);
if alpha < 1 { draw_sprite_ext(sprBTPBar, 2, 36, 119, 0.5, 0.5*orangeLen+0.005, 0, c_white, 1); }
draw_sprite_ext(sprBTPBar, 1, 36, 119, 0.5, 0.5*orangeLen, 0, c_white, 1);
draw_self();

draw_set_font(fntDialogue);
draw_set_halign(fa_middle);
if global.tp < 100 { draw_text_ext(24, 56, $"{floor(global.tp)}\n%", 12, 999); }
else
{
	draw_set_color(c_yellow);
	draw_text_ext(20, 56, "M\n A\n  X", 12, 999);
	draw_set_color(c_white);
}