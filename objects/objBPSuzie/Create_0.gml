_name = "Joy";
ind = 2;
_type = "Player";

hp = 110;
maxHp = 110;
atk = 4;
df = 1;
tempDf = 0;

prefix = "J";

magic[0] = "Rude Buster";
magic[1] = "Happy Heal";
magicDesc[0] = "Heavy\ndamage";
magicDesc[1] = "Heals like\n20HP idk";
magicCost[0] = 40;
magicCost[1] = 50;
magicTarget[0] = "Enemies";
magicTarget[1] = "Players";

selected = false;
aCol = c_black;
highlightDir = 0;

///@func magicUse(ind, target)
magicUse = function(ind, target)
{
	if ind == 0 { doDamage(80, 2, target); audio_play_sound(sndDamage, 10, false); }
	else { doHeal(irandom_range(18, 22), target, false); audio_play_sound(sndSpell, 10, false); }
}