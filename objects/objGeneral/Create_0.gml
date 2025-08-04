#macro horizontal 0
#macro vertical 1

#macro freeroam 0
#macro dialogue 1
#macro cutscene 2
#macro battle 3

randomize();

global.playerState = freeroam;

global.textSide = 1;

global.battleRound = 2;

for (var i = 0; i < 12; i++) { global.inventory[i] = -1; }
for (var i = 0; i < 12; i++) { global.usingInv[i] = false; }
global.invLength = -1;

//DEBUG PURPOSES
for (var i = 0; i < 9; i++) { global.inventory[i] = choose(0, 1, 2); }

global.invId[0] = objItem0;
global.invId[1] = objItem1;
global.invId[2] = objItem2;

global.ddollars = 0;

for (var i = 0; i < array_length(global.invId); i++)
{ global.invId[i] = instance_create_layer(x, y, "Instances", global.invId[i]); }

global.debug = true;

shake = false;

room_goto(rmBattle);
objPlayer.x = 40;
objPlayer.y = 153;