depthException = true;
depth = origin.depth - 1;

var col = [ #FFFF00, #00FFFF, #FF00FF, #00FF00 ];

image_xscale = 0.5;
image_yscale = 0.5;
image_blend = col[origin.image_index];

if offset != 0 { image_speed = 0; alarm[0] = offset; }