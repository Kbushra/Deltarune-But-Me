draw_self();

if pos < string_length(_text[page]) && delay <= 0
{
	pos += typeSpeed;
	charCounter += typeSpeed;
	
	currChar[0] = string_char_at(_text[page], pos);
	if currChar[0] == "." || currChar[0] == "!" || currChar[0] == "?" { delay = 10; }
	if currChar[0] != " " { audio_play_sound(sndText, 10, false); }
}

delay--;

var offset = 0;
if face != -1 { draw_sprite(face, 0, x-84, y); offset = 60; }

draw_set_font(fntDialogue);
draw_set_halign(align);
draw_text_transformed_color(x-109+offset, y-29, string_copy(_text[page], 1, pos),
	1, 1, 0, col, col, col, col, 1);