if sndId != -1 { exit; }

if global.turn == 0 { bubbleEnd = false; }

if global.turn == 1 && !bubbleEnd && bubble == -1
{
	var randBubble = irandom_range(0, array_length(bubbleText) - 1);
	bubble = blub(bubbleText[randBubble], id, x - 20);
}

if bubbleEnd { bubble = -1; }