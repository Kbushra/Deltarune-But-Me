depthException = true;

image_xscale = 0.5;
image_yscale = 0.5;
image_index = origin.ind;

instance_create_layer(x, y, "PlayerMenus", objBPMenuAnimate, { offset: 0, origin: id });
instance_create_layer(x, y, "PlayerMenus", objBPMenuAnimate, { offset: 15, origin: id });