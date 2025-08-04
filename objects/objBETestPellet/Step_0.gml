if big
{
	image_xscale = 5;
	image_yscale = 5;
	direction = point_direction(x, y, objBSoul.x, objBSoul.y);
	speed = 0.5;
	if alarm[0] <= 0 { alarm[0] = 30; }
}

image_alpha += 0.2;