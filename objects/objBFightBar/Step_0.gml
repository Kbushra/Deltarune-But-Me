if destroy
{
	image_xscale += 0.1;
	image_yscale += 0.1;
	image_alpha -= 0.1;
	
	if x == 42 { image_blend = c_yellow; }
	if !stop { x -= 4; }
	
	if image_alpha <= 0 && alarm[1] <= 0
	{
		if instance_number(objBFightBar) == 1 { objBFightUI.activated = false; }
		instance_destroy();
	}
	
	exit;
}

if global.enemyCount <= 0 { destroy = true; stop = false; exit; }

target = validEnemy(objBMButtons.savedSelection[ind][1]);

if global.confirm && x <= objBFightUI.x + 99 && x >= 20
{
	audio_play_sound(sndSlash, 10, false);
	
	alarm[1] = 15;
	destroy = true;
	stop = true;
	
	exit;
}

x -= 4;
if x > objBFightUI.x + 80 { points += 6; }
else if x > objBFightUI.x + 69 { points += 12; }
else if x > 42 { points += 24; }
else { points -= 60; }

if x > 42 { alarm[0] = 2; }
if snap == true && x < 42 { x = 42; }

if x < 20
{
	destroy = true;
	stop = false;
	if !instance_exists(objBMessages)
	{ instance_create_layer(x, y, "Text", objBMessages, { origin: target, ind: 0 }); }
}