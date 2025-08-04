if global.enemyCount <= 0
{	
	if !instance_exists(objChatbox) && !chatEnd
	{
		audio_stop_sound(musRuder);
		chat($"* You won!\n* Got 0 EXP and {earnings} D$.");
		
		global.ddollars += earnings;
		earnings = 0;
		chatEnd = true;
	}
	else if !instance_exists(objChatbox) { room_goto(rmHallway); }
	exit;
}

if global.turn == 1 { chatTurnText = true; exit; }

if doSelections
{
	if character >= global.partyCount
	{
		if array_length(objBFightUI.fighter) == 0
		{
			global.turn = 1;
			objBBox.settingUp = true;
			doSelections = false;
			sortInventory();
			resetSelection();
			exit;
		}
		
		if objBFightUI.image_alpha <= 0
		{
			objBFightUI.activated = true;
			objBFightUI.attacking = true;
			objBFightUI.image_alpha = 1;
			
			var arr = [];
			array_copy(arr, 0, [0, choose(0, 1), choose(1, 2)], 0, array_length(objBFightUI.fighter));
			if array_contains(arr, 2) && !array_contains(arr, 1) { arr[array_get_index(arr, 2)] = 1; }
			
			var shifts = array_shuffle(arr);
			for (var i = 0; i < array_length(objBFightUI.fighter); i++)
			{
				instance_create_layer(x, y, "PlayerMenus", objBFightBar,
					{ ind: objBFightUI.fighter[i], num: i, shift: shifts[i] });
			}
		}
		exit;
	}
	
	if savedSelection[character][0] == -1
	{
		changeCharacter(true, false);
		event_perform(ev_step, ev_step_normal);
		exit;
	}
	
	if savedSelection[character][0] == 4
	{
		changeCharacter(true, false);
		event_perform(ev_step, ev_step_normal);
		exit;
	}
	
	if savedSelection[character][0] == 3
	{
		if textEnd
		{
			textEnd = false;
			changeCharacter(true, false);
			event_perform(ev_step, ev_step_normal);
			exit;
		}
		
		if instance_exists(objChatbox) { exit; }
		
		var inst = validEnemy(savedSelection[character][1]);
		
		if inst.mercyMeter >= 100
		{
			chat([ $"* {global.playerMenu[character].origin._name} spared {inst._name}!" ]);
			
			inst.spared = true;
			audio_play_sound(sndSpare, 10, false);
			array_delete(global.enemyInstance, array_get_index(global.enemyInstance, inst), 1);
			global.enemyCount--;
		}
		else { chat([ $"* {global.playerMenu[character].origin._name} tried to spare {inst._name}.\n* But it's name wasn't yellow..." ]); }
	}
	
	if savedSelection[character][0] == 2
	{
		if textEnd
		{
			textEnd = false;
			changeCharacter(true, false);
			event_perform(ev_step, ev_step_normal);
			exit;
		}
		
		if instance_exists(objChatbox) { exit; }
		
		var itemId = global.inventory[savedSelection[character][1]];
		var item = global.invId[itemId];
		var ta = -1;
		
		if item.useTarget != "None"
		{
			if item.useTarget == "Enemies" { var ta = validEnemy(savedSelection[character][2]); }
			else { ta = global.playerMenu[savedSelection[character][2]].origin; }
			
			chat([ $"* {global.playerMenu[character].origin._name} used {item._name} on {ta._name}." ]);
		}
		else { chat([ $"* {global.playerMenu[character].origin._name} used {item._name}." ]); }
		
		item.use(ta);
		global.inventory[savedSelection[character][1]] = -1;
	}
	
	if savedSelection[character][0] == 1 && global.playerMenu[character].ind == 1
	{
		if textEnd
		{
			textEnd = false;
			changeCharacter(true, false);
			event_perform(ev_step, ev_step_normal);
			exit;
		}
		
		if instance_exists(objChatbox) { exit; }
		
		//Shouldnt become invalid because acting is the first action but just incase
		var inst = validEnemy(savedSelection[character][1]);
		var txt = inst.actText[savedSelection[character][2]];
		chat(txt);
		inst.chosenAct = savedSelection[character][2];
	}
	else if savedSelection[character][0] == 1
	{
		if textEnd
		{
			textEnd = false;
			changeCharacter(true, false);
			event_perform(ev_step, ev_step_normal);
			exit;
		}
		
		if instance_exists(objChatbox) { exit; }
		
		if savedSelection[character][1] == 0
		{
			var pref = global.playerMenu[character].origin.prefix;
			var inst = validEnemy(savedSelection[character][2]);
			var txt = variable_instance_get(inst, $"actText{pref}");
			chat(txt);
			inst.chosenAct = pref;
		}
		else
		{
			var user = global.playerMenu[character].origin;
			if user.magicTarget[savedSelection[character][1] - 1] == "Enemies"
			{ var ta = validEnemy(savedSelection[character][2]); }
			else { var ta = global.playerMenu[savedSelection[character][2]].origin; }
			
			chat([ $"* {user._name} used {user.magic[savedSelection[character][1] - 1]} on {ta._name}." ]);
			user.magicUse(savedSelection[character][1] - 1, ta);
		}
	}
	
	if savedSelection[character][0] == 0
	{
		array_push(objBFightUI.fighter, character);
		changeCharacter(true, false);
		event_perform(ev_step, ev_step_normal);
		exit;
	}
	
	exit;
}

if character == 0 && !array_contains(global.playersUp, 0) { changeCharacter(true, false); }

currPlayer = global.playerMenu[character];
currSelection = selection[character];
currPInst = global.partyId[currPlayer.ind];

menuManagement();

if character == clamp(character, 0, global.partyCount-1)
{ global.playerMenu[character].button[selection[character][0]].on = true; }

if instance_exists(objChatbox) { objChatbox.visible = menu == 0; }

if character >= global.partyCount { instance_destroy(objChatbox); doSelections = true; character = 0; }

if !chatTurnText { exit; }

if global.turnCount == 0
{
	var twoSame = global.enemyCount == 2 && global.enemyInstance[0].ind == global.enemyInstance[1].ind;
	var threeSame = global.enemyCount == 3 && global.enemyInstance[0].ind == global.enemyInstance[1].ind &&
		global.enemyInstance[0].ind == global.enemyInstance[2].ind;
	
	if global.enemyCount == 1 { chat(global.enemyInstance[0].introText[0]); }
	else if twoSame { chat(global.enemyInstance[0].introText[1]); }
	else if threeSame { chat(global.enemyInstance[0].introText[2]); }
	else if global.enemyCount == 2
	{ chat([ $"{global.enemyInstance[0]._name} and {global.enemyInstance[1]._name} appeared!" ]); }
	else if global.enemyCount == 3
	{ chat([ $"{global.enemyInstance[0]._name}, {global.enemyInstance[1]._name} and {global.enemyInstance[1]._name} appeared!" ]); }
}
else
{
	var randEnemy = irandom_range(0, global.enemyCount - 1);
	var randFlav = irandom_range(0, array_length(global.enemyInstance[randEnemy].flavourText) - 1);
	chat(global.enemyInstance[randEnemy].flavourText[randFlav]);
}

chatTurnText = false;