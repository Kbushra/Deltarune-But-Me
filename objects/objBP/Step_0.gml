if global.turn == 1 { multiAct = false; }
on = objBMButtons.character == order && global.turn == 0 && !objBMButtons.doSelections;

if on { y = lerp(y, 148, 0.4); sprite_index = sprBP; }
else { y = lerp(y, 164, 0.4); sprite_index = sprBPOff; }

if origin.hp <= 0 && array_contains(global.playersUp, order)
{ array_delete(global.playersUp, array_get_index(global.playersUp, order), 1); }

else if origin.hp > 0 && !array_contains(global.playersUp, order)
{ array_push(global.playersUp, order); }