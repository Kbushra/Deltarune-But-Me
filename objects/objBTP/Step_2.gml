global.tp = clamp(global.tp, 0, 100);

if orangeTP < global.tp - 1
{
	if global.tp < 100 { orangeTP = lerp(orangeTP, global.tp - 1, 0.2); }
	else { orangeTP = lerp(orangeTP, 100, 0.2); }
	orangeTP = clamp(orangeTP, 0, 100);
	
	whiteTP = global.tp;
	whiteTP = clamp(whiteTP, 0, 100);
}
else
{
	whiteTP = lerp(whiteTP, global.tp, 0.2);
	whiteTP = clamp(whiteTP, 0, 100);
	
	orangeTP = global.tp - 1;
	if global.tp >= 100 { orangeTP = 100; }
	orangeTP = clamp(orangeTP, 0, 100);
}

if highlightAmount != 0
{
	if global.tp >= highlightAmount
	{
		if alpha <= 0.3 { highlightDir = 1/30; }
		if alpha >= 1 { highlightDir = -1/30; }
	
		alpha += highlightDir;
	}
	else { alpha = 0.3; }
}
else { alpha = 1; }