image_alpha = global.turn == 1 && !instance_exists(objBBubble);

if global.turn == 0 { global.priority = [-1, -1, -1]; global.atkCounter = 0; }

if global.turn == 0 || settingUp
{
	objBSoul.x = x;
	objBSoul.y = y;
}

for (var i = array_length(prevAngle) - 1; i >= 0; i--)
{
	if i == 0 { prevAngle[0] = fadeAngle; break; }
	prevAngle[i] = prevAngle[i-1];
}

if settingUp && image_alpha == 1
{
	image_xscale = lerp(image_xscale, targScaleX, 0.2);
	image_yscale = lerp(image_yscale, targScaleY, 0.2);
	x = lerp(x, targX, 0.2);
	y = lerp(y, targY, 0.2);
	
	fadeAngle = lerp(fadeAngle, 182, 0.2);
	if fadeAngle >= 180
	{
		fadeAngle = 180;
		settingUp = false;
	}
}

if !settingUp && !finishing && global.turn == 1
{
	attackLength--;
	if attackLength <= 0 && !finishing
	{
		global.turnCount++;
		finishing = true;
		instance_destroy(objBBulletParent);
	}
}

if finishing
{
	image_xscale = lerp(image_xscale, 0, 0.2);
	image_yscale = lerp(image_yscale, 0, 0.2);
	x = lerp(x, 153, 0.2);
	y = lerp(y, 85, 0.2);
	
	fadeAngle = lerp(fadeAngle, -2, 0.2);
	if fadeAngle <= 0
	{
		fadeAngle = 0;
		finishing = false;
		global.turn = 0;
		image_alpha = 0;
		
		with objBPPlayerParent { tempDf = 0; }
	}
}