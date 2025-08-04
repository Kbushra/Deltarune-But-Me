depthException = true;
depth = -99999;

_offset = -1;
with objBNumbers { if instance_exists(origin) && origin.id == other.origin.id { other._offset += 1; } }

originY = origin.y;
x = origin.x;
y = origin.y;

side = x < 160;
velo = 0;
grav = 0.8;
bounce = 0;

x += 20 * (1 + -2*side);

image_yscale = 0.1;

alarm[0] = 30;