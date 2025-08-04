if global.battleRound == 0
{
	global.enemy[0] = 0;
	global.enemyCount = 1;
}

if global.battleRound == 1
{
	global.enemy[0] = 0;
	global.enemy[1] = 0;
	global.enemyCount = 2;
}

if global.battleRound == 2
{
	global.enemy[0] = 0;
	global.enemy[1] = 0;
	global.enemy[2] = 0;
	global.enemyCount = 3;
}


switch global.enemyCount
{
	case 1:
		enemyPos[0] = 76;
		break;
	
	case 2:
		enemyPos[0] = 54;
		enemyPos[1] = 98;
		break;
	
	case 3:
		enemyPos[0] = 33;
		enemyPos[1] = 76;
		enemyPos[2] = 119;
}

for (var i = 0; i < global.partyCount; i++)
{
	global.enemyInstance[i] = instance_create_layer(260, enemyPos[i], "Enemies",
		global.enemyId[global.enemy[i]]);
}