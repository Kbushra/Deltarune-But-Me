//Checks 5 times incase any special characters are comboed (will stop looping if none found)
for (var i = 0; i < 5; i++)
{
	currChar[0] = string_char_at(_text[page], pos);
	currChar[1] = string_char_at(_text[page], pos+1);
	currChar[2] = string_char_at(_text[page], pos+2);
	
	#region Character
	if currChar[0] == "["
	{
		face = asset_get_index($"sprFace{currChar[1]}{currChar[2]}");
		_text[page] = string_delete(_text[page], pos, 3);
		continue;
	}
	#endregion
	
	#region Speed
	if currChar[0] == "^"
	{
		typeSpeed = real(currChar[1]);
		_text[page] = string_delete(_text[page], pos, 2);
		continue;
	}
	if currChar[1] == "_"
	{
		typeSpeed = real(currChar[0])/real(currChar[2]);
		_text[page] = string_delete(_text[page], pos, 3);
		continue;
	}
	#endregion
	
	if currChar[0] != "\\" { break; } //Characters after this use \\
	
	/*
	#region Choices
	if currChar[1] == "C" && !instance_exists(obj_choicer)
	{
		instance_create_depth(0, 0, depth-999, obj_choicer);
		_text[page] = string_delete(_text[page], pos, 2);
		preventer = "c";
		continue;
	}
	#endregion
	*/
	
	#region Colour
	if currChar[1] == "c"
	{
		switch currChar[2]
		{
			case "R": col = c_red; break;
			case "Y": col = c_yellow; break;
			case "B": col = c_blue; break;
			case "G": col = c_green; break;
			case "W": col = c_white; break;
			case "E": col = c_grey; break;
		}
		
		_text[page] = string_delete(_text[page], pos, 3);
		continue;
	}
	#endregion
	
	#region Prevent skipping/continuing (s/c)
	if currChar[1] == "p"
	{
		preventer = currChar[2];
		_text[page] = string_delete(_text[page], pos, 3);
		continue;
	}
	#endregion
}

#region Line breaks
if currChar[0] == " "
{
	var count = 0;
	for (var letter = pos+1; letter < pos+20; letter++)
	{
		if string_char_at(_text[page], letter) == " "
			|| letter >= string_length(_text[page]) { break; }
		
		count++;
		if count == 19 { count = 0; }
	}
	
	if charCounter + count > breakCount
	{
		charCounter = 0;
		_text[page] = string_insert("\n  ", _text[page], pos+1);
	}
}

if currChar[0] == "\n" { charCounter = 0; }
#endregion