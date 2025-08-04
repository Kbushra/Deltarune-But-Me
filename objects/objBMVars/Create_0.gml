global.playerState = battle;

global.battleSurface = -1; //For bullets

global.turn = 0;
global.turnCount = 0;

global.battleFont[0] = font_add_sprite_ext(sprBHPFont, "0123456789+-", true, 1);
global.battleFont[1] = font_add_sprite_ext(sprBMessageFont, "0123456789+-%", true, 1);
global.battleFont[2] = font_add_sprite_ext(sprBMessageGFont, "0123456789+-%", true, 1);

global.partyId[0] = objBPNoelle;
global.partyId[1] = objBPKris;
global.partyId[2] = objBPSuzie;

global.partyColour[0] = #FFFF7F;
global.partyColour[1] = #00A2E8;
global.partyColour[2] = #EA79C8;
global.partyColour[3] = c_white;

global.enemyId[0] = objBETest;

//Set by player manager
global.party[0] = -1;
global.party[1] = -1;
global.party[2] = -1;
global.partyCount = 0;

//Set by enemy manager
global.enemy[0] = -1;
global.enemy[1] = -1;
global.enemy[2] = -1;
global.enemyCount = 0;

global.tp = 0;

global.bubbleSfx = false; //Only one bubble plays sfx

//Attack priority (0 - 2, L - H)
global.priority[0] = -1;
global.priority[1] = -1;
global.priority[2] = -1;
global.atkCounter = 0;

//Player menu in players
//Chosen battle is global.battleRound (general and panel)