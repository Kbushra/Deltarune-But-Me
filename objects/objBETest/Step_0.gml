if global.turn == 0 || instance_exists(objBBubble) || objBBox.finishing
{
	currAttack = choose(0, 0, 0, 1, 1, 2);
	setup = false;
	filtered = false;
	doAttack = true;
	exit;
}

if objBBox.settingUp && !instance_exists(objBBubble)
{
	if !setup
	{
		if currAttack == 0 { setupAttack( , , , , , priority[currAttack], 0); }
		if currAttack == 1 { setupAttack(7, 2, , 40, , priority[currAttack], 30); }
		if currAttack == 2 { setupAttack(7, 7, , , , priority[currAttack], 0); }
	
		setup = true;
	}
	else if !filtered { filterAttack(priority[currAttack]); filtered = true; }
	
	exit;
}

attackDelay--;
if attackDelay > 0 || !doAttack { exit; }

if currAttack == 0
{
	attackDelay = 20;
	var side = choose(0, 1);
	
	if side == 0
	{
		var bulletX = irandom_range(objBBox.bbox_left - 20, objBBox.bbox_right + 20);
		var bulletY = choose(objBBox.bbox_top - 20, objBBox.bbox_bottom + 20);
	}
	else
	{
		var bulletX = choose(objBBox.bbox_left - 20, objBBox.bbox_right + 20);
		var bulletY = irandom_range(objBBox.bbox_top - 20, objBBox.bbox_bottom + 20);
	}
	
	instance_create_layer(bulletX, bulletY, "BBox", objBETestPellet, { big: false, origin: id });
}

if currAttack == 1
{
	attackDelay = 25;
	var side = choose(0, 1);
	
	var bulletX = choose(objBBox.bbox_left - 20, objBBox.bbox_right + 20);
	var bulletY = irandom_range(objBBox.bbox_top - 20, objBBox.bbox_bottom + 20);
	
	instance_create_layer(bulletX, bulletY, "BBox", objBETestPellet, { big: false, origin: id });
}

if currAttack == 2
{
	attackDelay = 999;
	
	for (var i = 0; i < 4; i++)
	{
		var arrX = [objBBox.bbox_left - 20, objBBox.bbox_right + 20];
		var arrY = [objBBox.bbox_top - 20, objBBox.bbox_bottom + 20];
		var bulletX = arrX[i>1];
		var bulletY = arrY[i%2==1];
	
		instance_create_layer(bulletX, bulletY, "BBox", objBETestPellet, { big: true, origin: id });
	}
}