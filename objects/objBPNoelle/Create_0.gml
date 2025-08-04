_name = "Nic";
ind = 0;
_type = "Player";

hp = 90;
maxHp = 90;
atk = 2;
df = 3;
tempDf = 0;

prefix = "N";

magic[0] = "Support";
magic[1] = "Freezer";
magicDesc[0] = "Revives\nDOWNED";
magicDesc[1] = "Puts enemy\nin freezer";
magicCost[0] = 80;
magicCost[1] = 100;
magicTarget[0] = "Players";
magicTarget[1] = "Enemies";

selected = false;
aCol = c_black;
highlightDir = 0;

///@func magicUse(ind, target)
magicUse = function(ind, target)
{
	if ind == 0 { doHeal(9999, target, false); audio_play_sound(sndSpell, 10, false); }
	else { doDamage(9999, 0, target); audio_play_sound(sndDamage, 10, false); }
}