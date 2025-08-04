if chosenAct == 2 { doMercy(60); }
if chosenAct == 3 { doMercy(100); }
if chosenAct == "J" { doMercy(25); }
if chosenAct == "N" { doMercy(40); }
chosenAct = -1;

if selected
{
	if color_get_red(aCol) <= 0 { highlightDir = 255/15; }
	if color_get_red(aCol) >= 255 { highlightDir = -255/15; }
	
	aCol = make_color_rgb(color_get_red(aCol) + highlightDir,
		color_get_green(aCol) + highlightDir, color_get_blue(aCol) + highlightDir);
}
else { aCol = c_black; }

if spared
{
	if image_alpha >= 1 { objBMButtons.earnings += ddollars; }
	
	x += 5;
	image_alpha -= 0.1;
	if image_alpha <= 0 { instance_destroy(); }
}

if hp <= 0
{
	if sndId == -1
	{
		sndId = audio_play_sound(sndDefeatFlee, 10, false);
		array_delete(global.enemyInstance, array_get_index(global.enemyInstance, id), 1);
		global.enemyCount--;
		
		objBMButtons.earnings += ddollars;
	}
	else if audio_sound_get_track_position(sndId) > 0.4 { x += 15; image_xscale += 0.2; }
	
	if x > 500 { instance_destroy(); }
}