visible = objBBox.image_alpha && !objBBox.finishing;

if !visible || objBBox.settingUp
{
	invFrames = 0;
	image_speed = 0;
	image_index = 0;
	exit;
}

x += (global.r - global.l)*spd;
y += (global.d - global.u)*spd;

if x > objBBox.bbox_right - 6 { x = objBBox.bbox_right - 6; }
if y > objBBox.bbox_bottom - 6 { y = objBBox.bbox_bottom - 6; }
if x < objBBox.bbox_left + 6 { x = objBBox.bbox_left + 6; }
if y < objBBox.bbox_top + 6 { y = objBBox.bbox_top + 6; }

with objBBulletParent
{
	if place_meeting(x, y, other)
	{
		if other.invFrames <= 0
		{
			other.invFrames = 30;
			audio_play_sound(sndHurt, 10, false);
			
			if array_length(global.playersUp) <= 0 { exit; }
			var ind = global.playersUp[irandom_range(0, array_length(global.playersUp)-1)];
			var player = global.playerMenu[ind].origin;
		
			var dmg = origin.atk*9 - player.df*3;
			dmg += irandom_range(-3, 3);
			if dmg < 1 { dmg = 1; }
		
			doDamage(dmg, 3, player);
			other.image_index = 1;
		}
		
		if destroy { instance_destroy(); }
	}
}

invFrames--;
image_speed = invFrames > 0;
if image_speed == 0 { image_index = 0; }
if invFrames > 20 { camShake(); }

if array_equals(global.playersUp, [])
{
	room_goto(rmGameOver);
	audio_stop_all();
	objGameover.alarm[0] = 30;
}