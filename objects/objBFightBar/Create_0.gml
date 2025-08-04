x = objBFightUI.x + 159 + 70*shift;
y = objBFightUI.y + 10 + 18*num;

points = 500;
destroy = false;
stop = false;

attacker = global.playerMenu[ind].origin;
target = validEnemy(objBMButtons.savedSelection[ind][1]);

snap = true;