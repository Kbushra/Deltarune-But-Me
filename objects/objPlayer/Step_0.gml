visible = global.playerState != battle;

spd = global.cancelH ? 3 : 2;
image_speed = spd/2;

if global.playerState != freeroam
{
	state = "I";
	//sprite_index = asset_get_index($"sprPlayer{dir}{state}");
	exit;
}

hSpd = (global.r - global.l) * spd;
vSpd = (global.d - global.u) * spd;

if global.d - global.u != 0 || global.r - global.l != 0 { state = ""; }
else { image_index = 0; state = "I"; }

if place_free(x + hSpd, y + vSpd)
{
	x += hSpd;
	y += vSpd;
}
else
{
	for (var i = 0; i < spd; i++)
	{
		if !place_free(x + global.r - global.l, y)
		{
			image_index = 0;
			state = "I";
			if i == 0 && vSpd != 0 { hSpd = 0; } //For dir
			break;
		}
		
		x += global.r - global.l;
		
	}
	
	for (var i = 0; i < spd; i++)
	{
		if !place_free(x, y + global.d - global.u)
		{
			image_index = 0;
			state = "I";
			if i == 0 && hSpd != 0 { vSpd = 0; } //For dir
			break;
		}
		
		y += global.d - global.u;
	}
}

dir = new_dir();
//sprite_index = asset_get_index($"sprPlayer{dir}{state}");