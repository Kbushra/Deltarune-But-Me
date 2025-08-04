draw_self();

if pos < string_length(_text[page]) && delay <= 0
{
	pos++;
	
	currChar[0] = string_char_at(_text[page], pos);
	if currChar[0] == "." || currChar[0] == "!" || currChar[0] == "?" { delay = 10; }
	
	if currChar[0] != " " && !global.bubbleSfx
	{
		audio_play_sound(sndText, 10, false);
		global.bubbleSfx = true;
	}
}

delay--;

draw_set_font(fntDialogue);
draw_set_halign(fa_middle);
yOffset = !multLines ? -5 : -8;

draw_text_ext_transformed_color(x-35, y+yOffset, string_copy(_text[page], 1, pos), 13, 80,
	0.5, 0.5, 0, col, col, col, col, 1);

draw_set_halign(fa_left);