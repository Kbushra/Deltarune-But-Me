// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dir_axis()
{
	if dir == "L" || dir == "R" { return horizontal; }
	if dir == "U" || dir == "D" { return vertical; }
	return -1;
}

function new_dir()
{
	//If horizontal prioritise horizontal axis and vice versa
	if dir_axis() == horizontal
	{
		if hSpd > 0 { return "R"; }
		if hSpd < 0 { return "L"; }
	
		if vSpd > 0 { return "D"; }
		if vSpd < 0 { return "U"; }
	}
	else if dir_axis() == vertical
	{
		if vSpd > 0 { return "D"; }
		if vSpd < 0 { return "U"; }
		
		if hSpd > 0 { return "R"; }
		if hSpd < 0 { return "L"; }
	}
	
	return dir; //No change
}

function chat(reqText, reqOrigin = id)
{
	if !is_array(reqText) { reqText = [reqText]; }
	
	if instance_exists(objChatbox) { instance_destroy(objChatbox); }
	return instance_create_layer(x, y, "Text", objChatbox, { _text: reqText, origin: reqOrigin });
}

function blub(reqText, reqOrigin = id, reqX = x, reqY = y)
{
	return instance_create_layer(reqX, reqY, "Text", objBBubble,
		{ _text: reqText, origin: reqOrigin });
}

function sortInventory()
{
	for (var i = 0; i < array_length(global.inventory); i++)
	{
		var empty = false;
		
		while global.inventory[i] == -1
		{
			empty = true;
			for (var j = i; j < array_length(global.inventory) - 1; j++)
			{
				if global.inventory[j+1] != -1 { empty = false; }
				global.inventory[j] = global.inventory[j+1];
				global.inventory[j+1] = -1;
			}
			
			if empty { break; }
		}
		
		if empty { break; }
	}
}

function camShake(intensity = 1)
{
	objGeneral.shake = true;
	camPosition(); //Set cam correctly first
	
	camera_set_view_pos(view_camera[0],
		camera_get_view_x(view_camera[0]) + choose(intensity, -intensity),
			camera_get_view_x(view_camera[0]) + choose(intensity, -intensity));
}

function camPosition()
{
	var newX = clamp(objPlayer.x - 160, 0, room_width - 320);
	var newY = clamp(objPlayer.y - 120, 0, room_height - 240);
	camera_set_view_pos(view_camera[0], newX, newY);
}