if room != rmBattle
{
	y = camera_get_view_y(view_camera[0]) + 55 + (global.textSide*130);
	if face == -1 { breakCount = 26; } else { breakCount = 20; }
}

var next = global.confirm || global.menu;
var skip = global.cancel || global.menu;
if preventer == "s" { skip = false; }
if preventer == "c" { next = false; skip = false; }

if pos >= string_length(_text[page]) && next { page++; pos = 1; charCounter = 0; }
else if skip
{
	while pos < string_length(_text[page])
	{
		pos++;
		charCounter++;
		event_perform(ev_step, ev_step_end); //Do special character checks
	}
}

if page >= array_length(_text)
{
	if room != rmBattle { global.playerState = freeroam; }
	if origin != -1 { origin.textEnd = true; }
	
	instance_destroy();
}