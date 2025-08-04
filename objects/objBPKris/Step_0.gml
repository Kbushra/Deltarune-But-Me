if selected
{
	if color_get_red(aCol) <= 0 { highlightDir = 255/15; }
	if color_get_red(aCol) >= 255 { highlightDir = -255/15; }
	
	aCol = make_color_rgb(color_get_red(aCol) + highlightDir,
		color_get_green(aCol) + highlightDir, color_get_blue(aCol) + highlightDir);
}
else { aCol = c_black; }