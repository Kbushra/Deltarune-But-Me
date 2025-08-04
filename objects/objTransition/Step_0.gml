if fadeOut { image_alpha += 0.1; } else { image_alpha -= 0.1; }

if image_alpha >= 1 && fadeOut
{
	hold--;
	if hold > 0 { exit; }
	
	room_goto(targRoom);
	objPlayer.x = targX;
	objPlayer.y = targY;
	
	global.playerState = freeroam;
	fadeOut = false;
}

if image_alpha <= 0 && !fadeOut { instance_destroy(); }