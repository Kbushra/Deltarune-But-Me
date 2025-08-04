with objPlayer
{
	var shiftX = (dir == "R") - (dir == "L");
	var shiftY = (dir == "D") - (dir == "U");
	var interacting = place_meeting(x+shiftX, y+shiftY, other) && global.confirm;
	var canCreate = global.playerState == freeroam && !instance_exists(objChatbox) && !other.textEnd;
	
	if interacting && canCreate { chat(other._text, other.id); }
}

textEnd = false;