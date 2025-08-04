if global.enemyCount <= 0 { activated = false; }

if !activated && attacking
{
	image_alpha -= 0.1;
	if image_alpha <= 0 { fighter = []; attacking = false; }
}

draw_set_alpha(image_alpha);

if global.confirm { flashCol = [1, 1, 1, 0]; }

for (var i = 0; i < array_length(fighter); i++)
{
	var face = global.playerMenu[fighter[i]].origin.ind;
	draw_sprite_ext(sprBPFace, face, x + 13, y + 10 + i*18, 0.5, 0.5, 0, c_white, image_alpha);
	draw_sprite_ext(sprBPress, 0, x + 23, y + 3 + i*18, 0.5, 0.5, 0, c_white, image_alpha);
}

shader_set(shAdd);
shader_set_uniform_f_array(shader_get_uniform(shAdd, "addCol"), flashCol);
flashCol[0] -= 0.1;
flashCol[1] -= 0.1;
flashCol[2] -= 0.1;
if flashCol[0] < 0 { flashCol = [0, 0, 0, 0]; }

for (var i = 0; i < array_length(fighter); i++)
{
	var col = global.playerMenu[fighter[i]].origin.ind;
	draw_sprite(sprBPFightBars, col, x + 39, y + 1 + i*18);
}

shader_reset();

draw_set_alpha(1);