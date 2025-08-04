_name = "Test";
ind = 0;
_type = "Enemy";

hp = 150;
maxHp = 150;
atk = 3;
df = 3;
mercyMeter = 0;

ddollars = 18;

spared = false;

selected = false;
aCol = c_black;
highlightDir = 0;

chosenAct = -1;

#region Dialogue

introText[0] = ["\\pc* test."];
introText[1] = ["\\pc* test2."];
introText[2] = ["\\pc* test3."];
flavourText[0] = ["\\pc* The eyeballs check logs.\n* WHAT ARE THOSE?!"];
flavourText[1] = ["\\pc* Eyeballs have no mouth.\n* Yet they must scream."];
flavourText[2] = ["\\pc* Eyes, eyes, eyes all around me."];

bubbleText[0] = ["Eyeballs!"];
bubbleText[1] = ["Eyeballs?", "Thats what I am, yes."];
bubbleEnd = false;
bubble = -1;

act[0] = "Check";
act[1] = "Poke";
act[2] = "PokeJ";
act[3] = "PokeAll";

actReqs[0] = [];
actReqs[1] = [];
actReqs[2] = [0];
actReqs[3] = [0, 2];

actText[0] = ["* TEST - Just a test guys. Also lets see if this autobreak thing works."];
actText[1] = ["* You poked 1 eyeball.\n* Wasn't at all effective."];
actText[2] = ["* You and Joy poked some eyeballs.\n* Kind of worked."];
actText[3] = ["* Everyone poked an eyeball.\n* They can't be bothered anymore."];

actTextJ = ["* Suzie screamed at the eyeballs.\n* They couldn't hear."];
actTextN = ["* Noelle tried to impress the eyeballs by seeing.\n* Little did they know everyone sees."];

#endregion

attackDelay = 0;
doAttack = true;
setup = false;
filtered = false;

priority[0] = 0;
priority[1] = 1;
priority[2] = 2;

sndId = -1;