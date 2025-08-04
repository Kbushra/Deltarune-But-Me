if doSelections { exit; }

if menu == 1
{
	//FIGHT ACT MERCY
	var act = currSelection[0] == 1 && currPlayer.ind == 1;
	if currSelection[0] == 0 || act || currSelection[0] == 3 { enemyList(); }
	
	if currSelection[0] == 1 && !act { magicList(); }
	
	if currSelection[0] == 2 { itemList(); }
}

if menu == 2
{
	var act = currSelection[0] == 1 && currPlayer.ind == 1;
	if act { actList(); }
	
	if currSelection[0] == 1 && !act
	{
		if currSelection[1] == 0 || currPInst.magicTarget[currSelection[1] - 1] == "Enemies"
		{ enemyList(); } else { playerList(); }
	}
	
	if currSelection[0] == 2
	{
		if global.invId[ global.inventory[currSelection[1]] ].useTarget == "Enemies"
		{ enemyList(); } else { playerList(); }
	}
}