x = objBSoul.x;
y = objBSoul.y;
visible = objBSoul.visible;
cooldown--;

with objBBulletParent
{
	if place_meeting(x, y, other) && objBSoul.invFrames <= 0
	{
		if other.cooldown <= 0
		{
			if other.cooldown > -5 { other.combo++; }
			else { other.combo = 0; }
			
			if other.combo < comboSet { other.combo = comboSet; }
			
			if other.combo < 2 { global.tp += 1.8; other.cooldown = 8; }
			else if other.combo < 6 { global.tp += 1.2; other.cooldown = 5; }
			else { global.tp += 0.7; other.cooldown = 3; }
			
			audio_play_sound(sndGraze, 10, false);
		}
		
		other.image_index = 1;
		other.image_speed = 1;
	}
}

if image_index < 1 { image_speed = 0; }