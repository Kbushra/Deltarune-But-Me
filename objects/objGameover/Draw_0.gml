draw_sprite_ext(sprWhite, 0, 0, 0, room_width, room_height, 0, c_white, alpha);

if !array_equals(global.playersUp, []) { exit; }

draw_self();
draw_sprite_ext(sprBSoul, 0, global.soulX, global.soulY, 0.5, 0.5, 0, c_white, 1);

draw_sprite_ext(sprWhite, 0, 0, 0, room_width, room_height, 0, c_white, alpha);

if !startCutscene || time <= 0 { exit; }

draw_set_font(fntDialogue);
draw_set_halign(fa_middle);
draw_text(160, 160, $"Interactive section failed\nRetrying in {ceil(time/30)}");