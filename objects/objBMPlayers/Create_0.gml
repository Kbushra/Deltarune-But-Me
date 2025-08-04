if global.battleRound == 0
{
	global.party[0] = 0;
	global.partyCount = 1;
}

if global.battleRound == 1
{
	global.party[0] = 1;
	global.party[1] = 0;
	global.partyCount = 2;
}

if global.battleRound == 2
{
	global.party[0] = 1;
	global.party[1] = 2;
	global.party[2] = 0;
	global.partyCount = 3;
}


switch global.partyCount
{
	case 1:
		playerPos[0] = 76;
		menuPos[0] = 107;
		break;
	
	case 2:
		playerPos[0] = 54;
		playerPos[1] = 98;
		menuPos[0] = 54;
		menuPos[1] = 161;
		break;
	
	case 3:
		playerPos[0] = 33;
		playerPos[1] = 76;
		playerPos[2] = 119;
		menuPos[0] = 0;
		menuPos[1] = 107;
		menuPos[2] = 214;
}

global.playersUp = [];

for (var i = 0; i < global.partyCount; i++)
{
	array_push(global.playersUp, i);
	
	instance_create_layer(67, playerPos[i], "Players", global.partyId[global.party[i]]);
	global.playerMenu[i] = instance_create_layer(menuPos[i], 164, "Players", objBP,
		{ ind: global.party[i], order: i });
}