draw_self();

var actionSpr = asset_get_index($"sprBPActions{ind}");
var action = objBMButtons.savedSelection[order][0];

//J-Action or N-Action
if action == 1 && ind != 1 && objBMButtons.savedSelection[order][1] == 0 { action = 5; }

var correctOrder = objBMButtons.character > order || objBMButtons.doSelections;

if multiAct { draw_sprite_ext(actionSpr, 5, x+15, y+9, 0.5, 0.5, 0, c_white, 1); }

else if action != -1 && correctOrder
{ draw_sprite_ext(actionSpr, action, x+15, y+9, 0.5, 0.5, 0, c_white, 1); }

else { draw_sprite_ext(sprBPFace, ind, x+15, y+9, 0.5, 0.5, 0, c_white, 1); }

var scale = origin.hp/origin.maxHp;
scale = clamp(scale, 0, 1);
draw_sprite_ext(sprBPHP, 4, x+64, y+15, 0.5, 0.5, 0, c_white, 1);
draw_sprite_ext(sprBPHP, ind, x+64, y+15, 0.5*scale, 0.5, 0, c_white, 1);

draw_set_font(global.battleFont[0]);
draw_set_halign(fa_right);
draw_text(x+79, y+4, origin.hp);
draw_text(x+102, y+4, origin.maxHp);