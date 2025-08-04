function setupAttack(scaleX = 4, scaleY = 4, posX = 153, posY = 85, atkLength = 200, priorityLvl = -1, delay = 0)
{
	if max(global.priority[0], global.priority[1], global.priority[2]) < priorityLvl
	{
		objBBox.targScaleX = scaleX;
		objBBox.targScaleY = scaleY;
		objBBox.targX = posX;
		objBBox.targY = posY;
		objBBox.attackLength = atkLength;
		attackDelay = delay;
	}
	
	global.priority[array_get_index(global.priority, -1)] = floor(priorityLvl);
}

function filterAttack(priorityLvl = -1)
{
	//All attacks taken up
	if array_equals(global.priority, [-1, -1, -1]) { doAttack = false; return; }
	
	if array_contains(global.priority, 2)
	{
		if priorityLvl == 2
		{
			global.priority = [-1, -1, -1];
			global.atkCounter++;
			doAttack = true;
			return;
		}
		
		doAttack = false;
		return;
	}
	
	if array_contains(global.priority, 1) && priorityLvl == 1
	{
		global.priority[array_get_index(global.priority, 1)] = -1;
		global.atkCounter++;
		doAttack = true;
		
		if global.atkCounter == 2 { global.priority = [-1, -1, -1]; return; }
		
		var counter = 0;
		for (var i = 0; i < 3; i++)
		{
			if global.priority[i] != -1 { counter++; }
			if counter >= 2 { global.priority[i] = -1; }
		}
		
		return;
	}
	
	if array_contains(global.priority, 0) && priorityLvl == 0
	{
		if global.atkCounter == 1 && array_contains(global.priority, 1) { doAttack = false; return; }
		
		global.priority[array_get_index(global.priority, 0)] = -1;
		global.atkCounter++;
		doAttack = true;
		return;
	}
}

function validEnemy(ind)
{
	if global.enemyCount > ind { return global.enemyInstance[ind]; }
	return global.enemyInstance[irandom_range(0, global.enemyCount-1)];
}

function doMercy(amount, targ = id) //Enemy only
{
	if !instance_exists(targ) || !array_contains(global.enemyInstance, targ)
	{ targ = global.enemyInstance[irandom_range(0, global.enemyCount-1)]; }
	
	targ.mercyMeter += amount;
	audio_play_sound(sndMercyAdd, 10, false);
	
	instance_create_layer(x, y, "Text", objBNumbers,
		{ origin: targ, mercy: true, msg: $"+{amount}%" });
}

function doDamage(amount, attackerId, targ = id) //Enemy and player
{
	var enemyGone = !instance_exists(targ) || !array_contains(global.enemyInstance, targ);
	if targ._type == "Enemy" && enemyGone
	{ targ = global.enemyInstance[irandom_range(0, global.enemyCount-1)]; }
	
	targ.hp -= amount;
	
	if targ._type == "Player" && targ.hp <= 0
	{
		instance_create_layer(x, y, "Text", objBMessages,
			{ origin: targ, ind: 1 });
		
		return;
	}
	
	instance_create_layer(x, y, "Text", objBNumbers,
			{ origin: targ, mercy: false, msg: amount, ind: attackerId });
}

function doHeal(amount, targ = id, sound = true) //Player only
{
	targ.hp += amount;
	if sound { audio_play_sound(sndHeal, 10, false); }
	
	if targ.hp >= targ.maxHp
	{
		targ.hp = targ.maxHp;
		instance_create_layer(x, y, "Text", objBMessages,
			{ origin: targ, ind: 2 });
		
		return;
	}
	
	if !array_contains(global.playersUp, targ.order) && targ.hp > 0
	{
		instance_create_layer(x, y, "Text", objBMessages,
			{ origin: targ, ind: 3 });
		
		return;
	}
	
	instance_create_layer(x, y, "Text", objBNumbers,
			{ origin: targ, mercy: false, msg: amount });
}

function resetSelection()
{
	for (var i = 0; i < global.partyCount; i++)
	{
		//First index is party member, second is menu
		selection[i][0] = 0;
		selection[i][1] = 0;
		selection[i][2] = 0;
		savedSelection[i][0] = -1;
		savedSelection[i][1] = -1;
		savedSelection[i][2] = -1;
	}
	
	for (var i = 0; i < array_length(global.inventory); i++) { global.usingInv[i] = false; }
	
	menu = 0; //0 is buttons themselves
	character = 0;
}

#region Moving selections and drawing lists
function enemyList()
{
	draw_set_font(fntDialogue);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	for (var i = 0; i < global.enemyCount; i++)
	{
		var inst = global.enemyInstance[i];
		var _spareable = inst.mercyMeter == 100;
		if _spareable
		{
			draw_sprite_ext(sprBSpare, 0, 40 + string_width(inst._name), 193+(15*i),
				0.5, 0.5, 0, c_white, 1);
			draw_set_color(c_yellow);
		}
		else { draw_set_color(c_white); }
		
		draw_text(29, 188+(15*i), inst._name);
		draw_set_color(c_white);
		
		var hpRatio = inst.hp/inst.maxHp;
		draw_text_transformed(190, 184+(15*i), "HP", 1, 0.5, 0);
		draw_sprite(sprBBars, 1, 190, 199+(15*i));
		draw_sprite_ext(sprBBars, 0, 190, 199+(15*i), hpRatio, 1, 0, c_white, 1);
		
		draw_text_transformed(190, 191+(15*i), $"{floor(hpRatio*100)}%", 1, 0.5, 0);
		
		draw_text_transformed(255, 184+(15*i), "MERCY", 1, 0.5, 0);
		draw_sprite(sprBBars, 3, 255, 199+(15*i));
		draw_sprite_ext(sprBBars, 2, 255, 199+(15*i), inst.mercyMeter/100, 1, 0, c_white, 1);
		
		draw_set_color(#800000);
		draw_text_transformed(255, 191+(15*i), $"{inst.mercyMeter}%", 1, 0.5, 0);
		draw_set_color(c_white);
	}
	
	draw_sprite_ext(sprBSoul, 0, 22, 196+(15*currSelection[menu]), 0.5, 0.5, 0, c_white, 1);
}

function playerList()
{
	draw_set_font(fntDialogue);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	for (var i = 0; i < global.partyCount; i++)
	{
		var inst = global.playerMenu[i].origin;
		draw_text(29, 188+(15*i), inst._name);
		
		var hpRatio = inst.hp/inst.maxHp;
		draw_text_transformed(255, 184+(15*i), "HP", 1, 0.5, 0);
		draw_sprite(sprBBars, 1, 255, 199+(15*i));
		draw_sprite_ext(sprBBars, 0, 255, 199+(15*i), hpRatio, 1, 0, c_white, 1);
		
		draw_text_transformed(255, 191+(15*i), $"{floor(hpRatio*100)}%", 1, 0.5, 0);
	}
	
	draw_sprite_ext(sprBSoul, 0, 22, 196+(15*currSelection[menu]), 0.5, 0.5, 0, c_white, 1);
}

function linearSelection(cap, highlightInst)
{
	highlightInst.selected = true;
	
	currSelection[menu] += global.dP - global.uP;
	currSelection[menu] = (currSelection[menu] + cap+1) % (cap+1);
}

function rectSelection(cap)
{
	var prevSelection = currSelection[menu];
	
	var horiMove = global.rP || global.lP;
	var vertiMove = global.dP || global.uP;
	if currSelection[menu] < 2 && horiMove { currSelection[menu] = !currSelection[menu]; }
	else if horiMove { currSelection[menu] = !(currSelection[menu]-2) + 2; }
	
	if vertiMove { currSelection[menu] += 2; currSelection[menu] %= 4; }
	
	if currSelection[menu] >= cap { currSelection[menu] = prevSelection; }
}

function itemSelection()
{
	var prevSelection = currSelection[1];
	
	normSelection = currSelection[1] % 6;
	
	var horiMove = global.rP || global.lP;
	var vertiMove = global.dP || global.uP;
	if normSelection < 2 && horiMove { normSelection = !normSelection; }
	else if normSelection < 4 && horiMove { normSelection = !(normSelection-2) + 2; }
	else if horiMove { normSelection = !(normSelection-4) + 4; }
	
	if vertiMove { normSelection += 2 * (global.dP - global.uP); }
	
	currSelection[1] = normSelection + (currSelection[1] > 5)*6;
	
	//EDGECASE
	if currSelection[1] == 7 && global.invLength == 7 { currSelection[1] = 6; }
	
	if currSelection[1] >= global.invLength || currSelection[1] < 0
	{ currSelection[1] = prevSelection; }
}

function actList()
{
	draw_set_font(fntDialogue);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var inst = global.enemyInstance[currSelection[1]];
	for (var i = 0; i < array_length(inst.act); i++)
	{
		var xOffset = i % 2 == 1 ? 95 : 0;
		var yOffset = i > 1 ? 17 : 0;
		
		var reqsMet = true;
		for (var j = 0; j < array_length(inst.actReqs[i]); j++)
		{
			var player = global.partyId[inst.actReqs[i][j]];
			if !instance_exists(player) || !array_contains(global.playersUp, player.order)
			{ reqsMet = false; }
			
			draw_sprite_ext(sprBPFace, inst.actReqs[i][j],
				31 + string_width(inst.act[i]) + xOffset + (18*j), 194 + yOffset,
					0.5, 0.5, 0, c_white, 1);
		}
		
		if !reqsMet { draw_set_color(c_grey); }
		draw_text(20 + xOffset, 186 + yOffset, inst.act[i]);
		draw_set_color(c_white);
	}
	
	var xOffsetS = currSelection[2] % 2 == 1 ? 95 : 0;
	var yOffsetS = currSelection[2] > 1 ? 17 : 0;
	draw_sprite_ext(sprBSoul, 0, 13 + xOffsetS, 194 + yOffsetS, 0.5, 0.5, 0, c_white, 1);
}

function magicList()
{
	draw_set_font(fntDialogue);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	for (var i = 0; i < array_length(currPInst.magic) + 1; i++)
	{
		var xOffset = i % 2 == 1 ? 95 : 0;
		var yOffset = i > 1 ? 17 : 0;
		
		if i == 0
		{
			draw_set_color(global.partyColour[currPlayer.ind]);
			draw_text(20 + xOffset, 186 + yOffset, $"{currPInst.prefix}-Action");
		}
		else
		{
			if currPInst.magicCost[i-1] > global.tp { draw_set_color(c_grey); }
			draw_text(20 + xOffset, 186 + yOffset, currPInst.magic[i-1]);
		}
		
		draw_set_color(c_white);
	}
	
	var xOffsetS = currSelection[1] % 2 == 1 ? 95 : 0;
	var yOffsetS = currSelection[1] > 1 ? 17 : 0;
	draw_sprite_ext(sprBSoul, 0, 13 + xOffsetS, 194 + yOffsetS, 0.5, 0.5, 0, c_white, 1);
	
	if currSelection[1] != 0
	{
		draw_set_color(c_grey);
		draw_text(229, 186, currPInst.magicDesc[currSelection[1] - 1]);
		draw_set_color(c_orange);
		draw_text(229, 186 + string_height(currPInst.magicDesc[currSelection[1] - 1]),
			$"{currPInst.magicCost[currSelection[1] - 1]}% TP")
		draw_set_color(c_white);
	}
}

function itemList()
{
	draw_set_font(fntDialogue);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var page = currSelection[1] > 5;
	var limit = global.invLength - page*6;
	limit = clamp(limit, 0, 6);
	
	for (var i = page*6; i < limit + page*6; i++)
	{
		if global.usingInv[i] { draw_set_color(c_grey); }
		
		var xOffset = i % 2 == 1 ? 95 : 0;
		var yOffset = 17 * ((i - page*6) div 2);
		draw_text(20 + xOffset, 186 + yOffset, global.invId[global.inventory[i]]._name);
		
		draw_set_color(c_white);
	}
	
	var xOffsetS = currSelection[1] % 2 == 1 ? 95 : 0;
	var yOffsetS = 17 * ((currSelection[1] - page*6) div 2);
	draw_sprite_ext(sprBSoul, 0, 13 + xOffsetS, 194 + yOffsetS, 0.5, 0.5, 0, c_white, 1);
	
	draw_set_color(c_grey);
	draw_text(229, 186, global.invId[ global.inventory[currSelection[1]] ].desc);
	draw_set_color(c_white);
}
#endregion

function changeCharacter(next = true, changeSelection = true)
{	
	var tempCharacter = character;
	if next { character++; } else { character--; }
	
	var validCharacter = character == clamp(character, 0, global.partyCount-1);
	if !array_contains(global.playersUp, character) && validCharacter
	{
		while !array_contains(global.playersUp, character) && validCharacter
		{
			changeCharacter(next, false);
			validCharacter = character == clamp(character, 0, global.partyCount-1);
		}
		
		if !validCharacter && !next { character = tempCharacter; exit; }
	}
	
	while validCharacter && global.playerMenu[character].multiAct
	{
		if next { character++; } else { character--; }
		validCharacter = character == clamp(character, 0, global.partyCount-1);
	}
	
	if changeSelection
	{
		if !next
		{	
			currSelection[0] = 0;
			currSelection[1] = 0;
			currSelection[2] = 0;
			savedSelection[tempCharacter][0] = -1;
			savedSelection[tempCharacter][1] = -1;
			savedSelection[tempCharacter][2] = -1;
		}
		else
		{
			savedSelection[tempCharacter][0] = currSelection[0];
			savedSelection[tempCharacter][1] = currSelection[1];
			savedSelection[tempCharacter][2] = currSelection[2];
		}
		
		menu = 0;
	}
	
	if next || !validCharacter { exit; }
	
	if selection[character][0] == 4
	{ global.tp -= tempGain[character]; global.playerMenu[character].origin.tempDf -= 1; }
	
	if selection[character][0] == 1 && global.playerMenu[character].ind != 1
	{
		var inst = global.partyId[global.playerMenu[character].ind];
		
		if selection[character][1] != 0
		{ global.tp += inst.magicCost[selection[character][1] - 1]; }
	}
	
	if selection[character][0] == 2
	{ global.usingInv[selection[character][1]] = false; }
}

function buttonManagement()
{
	if savedSelection[character][0] != -1
	{
		currSelection[0] = savedSelection[character][0];
		currSelection[1] = 0;
		currSelection[2] = 0;
		savedSelection[character][0] = -1;
		savedSelection[character][1] = -1;
		savedSelection[character][2] = -1;
	}
	
	currSelection[0] += global.rP - global.lP;
	currSelection[0] = (currSelection[0] + 5) % 5;
	
	if global.confirm
	{
		if currSelection[0] == 2 && global.invLength == 0
		{ audio_play_sound(sndNoSelect, 10, false); exit; }
		
		audio_play_sound(sndSelect, 10, false);
		if currSelection[0] != 4 { menu++; exit; }
		
		//DEFEND
		var prevTp = global.tp;
		global.tp += dfGain;
		global.tp = clamp(global.tp, 0, 100);
		tempGain[character] = global.tp - prevTp;
		
		currPInst.tempDf += 1;
		
		changeCharacter(true);
		exit;
	}
	
	if global.cancel && character != 0
	{
		changeCharacter(false);
		with (objBP) { multiAct = false; }
		exit;
	}
}

function menuManagement()
{
	if menu == 0 { buttonManagement(); exit; }

	if menu == 1
	{
		if global.cancel { menu--; currSelection[1] = 0; exit; }
	
		var act = currSelection[0] == 1 && currPlayer.ind == 1;
		if currSelection[0] == 0 || act || currSelection[0] == 3
		{
			linearSelection(global.enemyCount - 1, global.enemyInstance[currSelection[1]]);
			
			if global.confirm
			{
				audio_play_sound(sndSelect, 10, false);
				
				//FIGHT AND MERCY
				if !act { changeCharacter(true); exit; }
				menu++;
				exit;
			}
			
			exit;
		}
		
		if currSelection[0] == 1 //MAGIC
		{
			rectSelection(array_length(currPInst.magic) + 1);
			
			if currSelection[1] == 0 { objBTP.highlightAmount = 0; }
			else { objBTP.highlightAmount = currPInst.magicCost[currSelection[1] - 1]; }
			
			var canUse = currSelection[1] == 0 ||
				currPInst.magicCost[currSelection[1] - 1] <= global.tp;
			
			if global.confirm
			{
				if !canUse { audio_play_sound(sndNoSelect, 10, false); exit; }
				
				audio_play_sound(sndSelect, 10, false);
				menu++;
				exit;
			}
		}
		
		if currSelection[0] == 2
		{
			itemSelection();
			
			if global.confirm
			{
				if global.usingInv[currSelection[1]] { audio_play_sound(sndNoSelect, 10, false); exit; }
				
				audio_play_sound(sndSelect, 10, false);
				
				if global.invId[ global.inventory[currSelection[1]] ].useTarget != "None" { menu++; }
				else { global.usingInv[currSelection[1]] = true; changeCharacter(true); }
				
				exit;
			}
		}
	}
	
	if menu == 2
	{
		if global.cancel { menu = 0; currSelection[2] = 0; currSelection[1] = 0; exit; }
		
		if currSelection[0] == 2
		{
			if global.invId[ global.inventory[currSelection[1]] ].useTarget != "Enemies"
			{
				var capped = global.partyCount - 1;
				var selectInst = global.playerMenu[currSelection[2]].origin;
			}
			else
			{
				var capped = global.enemyCount - 1;
				var selectInst = global.enemyInstance[currSelection[2]];
			}
		
			linearSelection(capped, selectInst);
			
			if global.confirm
			{
				audio_play_sound(sndSelect, 10, false);
				global.usingInv[currSelection[1]] = true;
				changeCharacter(true);
			}
			
			exit;
		}
		
		var act = currSelection[0] == 1 && currPlayer.ind == 1;
		if act
		{
			rectSelection(array_length( global.enemyInstance[currSelection[1]].act ));
			
			var inst = global.enemyInstance[currSelection[1]];
			inst.selected = true;
			
			if global.confirm
			{
				var reqsMet = true;
				for (var i = 0; i < array_length(inst.actReqs[currSelection[2]]); i++)
				{
					var player = global.partyId[inst.actReqs[currSelection[2]][i]];
					if !instance_exists(player) || !array_contains(global.playersUp, player.order)
					{ reqsMet = false; }
				}
				
				if !reqsMet { audio_play_sound(sndNoSelect, 10, false); exit; }
				
				audio_play_sound(sndSelect, 10, false);
				with (objBP)
				{
					var inst = global.enemyInstance[other.currSelection[1]];
					if array_contains(inst.actReqs[other.currSelection[2]], ind)
					{ multiAct = true; }
				}
				
				changeCharacter(true);
			}
			
			exit;
		}
		
		//MAGIC
		if currSelection[1] != 0 && currPInst.magicTarget[currSelection[1] - 1] != "Enemies"
		{
			var capped = global.partyCount - 1;
			var selectInst = global.playerMenu[currSelection[2]].origin;
		}
		else
		{
			var capped = global.enemyCount - 1;
			var selectInst = global.enemyInstance[currSelection[2]];
		}
		
		linearSelection(capped, selectInst);
		
		if currSelection[1] == 0 { objBTP.highlightAmount = 0; }
		else { objBTP.highlightAmount = currPInst.magicCost[currSelection[1] - 1]; }
			
		if global.confirm
		{
			audio_play_sound(sndSelect, 10, false);
			if currSelection[1] != 0
			{
				global.tp -= currPInst.magicCost[currSelection[1] - 1];
				objBTP.highlightAmount = 0;
			}
			
			changeCharacter(true);
			exit;
		}
	}
}