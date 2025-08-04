page = 0;
pos = 1;
charCounter = 0;

col = c_white;
face = -1;
typeSpeed = 1;
delay = 0;

align = fa_left;

currChar[0] = "";

preventer = "";

var temp = [];
array_copy(temp, 0, _text, 0, array_length(_text));
_text = temp;

depthException = true;
depth = -99999;

if room != rmBattle
{
	global.playerState = dialogue;
	
	x = camera_get_view_x(view_camera[0]) + 160;
	y = camera_get_view_y(view_camera[0]) + 55 + (global.textSide*130);
	breakCount = 26;
}
else
{
	image_alpha = 0;
	breakCount = 36;
	
	x = 124;
	y = 217;
}