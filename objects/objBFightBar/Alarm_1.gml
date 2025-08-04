if global.enemyCount <= objBMButtons.savedSelection[ind][1]
{ target = global.enemyInstance[irandom_range(0, global.enemyCount-1)]; }
else { target = global.enemyInstance[objBMButtons.savedSelection[ind][1]]; }

//Just in case
if !instance_exists(target) || target.sndId != -1 { exit; }

audio_play_sound(sndDamage, 10, false);

if x == 42 { points += irandom_range(125, 175); }
points += irandom_range(25, 75);
	
doDamage(floor(attacker.atk * points/30 - target.df*6), attacker.ind, target);