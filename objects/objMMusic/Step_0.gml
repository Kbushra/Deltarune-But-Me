if room == rmBattle && global.enemyCount > 0 && !audio_is_playing(musRuder)
{
	if global.mus != -1 { audio_stop_sound(global.mus); }
	global.mus = audio_play_sound(musRuder, 10, true);
}