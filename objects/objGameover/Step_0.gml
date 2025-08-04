if room != rmBattle && room != rmGameOver { instance_destroy(); exit; }

if !array_equals(global.playersUp, [])
{
	global.soulX = objBSoul.x;
	global.soulY = objBSoul.y;
	alpha -= 0.1;
	alpha = clamp(alpha, 0, 1);
	exit;
}

global.soulX = lerp(global.soulX, 160, 0.2);
global.soulY = lerp(global.soulY, 120, 0.2);

if startCutscene { image_alpha += 0.1; time--; }

if time <= 0
{
	alpha += 0.02;
	if alpha >= 1 && alarm[1] <= 0
	{ sndId = audio_play_sound(sndBattleHorn, 10, false); alarm[1] = 30; }
}

if sndId == -1 { exit; }

if sound == -1 { sound = 0; }

if audio_sound_get_track_position(sndId) > 0.25 && sound == 0
{ sndId = audio_play_sound(sndBattleHorn, 10, false); audio_sound_pitch(sndId, 1.1); sound++; }

var playWeapon = !audio_is_playing(sndBattleHorn) || audio_sound_get_track_position(sndId) > 0.5;

if playWeapon && sound == 1
{ sndId = audio_play_sound(sndSeizeWeapon, 10, false); sound++; }