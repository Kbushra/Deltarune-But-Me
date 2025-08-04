depthException = true;

image_xscale = 0.5;
image_yscale = 0.5;
image_index = ind;

on = false;

multiAct = false //If they're involved in a multi act (not the ACTer itself)

origin = global.partyId[ind];
origin.order = order;

instance_create_layer(x, 167, "PlayerMenus", objBPMenu, { origin: id });

for (var i = 0; i < 5; i++)
{
	if i == 1 && origin != objBPKris
	{
		button[i] = instance_create_layer(x+10+(17*i), 168, "Buttons", objBButtons, { ind: 5 });
		continue;
	}
	
	button[i] = instance_create_layer(x+10+(17*i), 168, "Buttons", objBButtons, { ind: i });
}