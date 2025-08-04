depthException = true;
depth = -99999;

originY = origin.y;
x = origin.x;
y = origin.y;

side = x > 160;
velo = 0;
grav = 0.8;
bounce = 0;

x += 20 * (1 + -2*side);

image_yscale = 0.1;

alarm[0] = 30;

image_index = ind;