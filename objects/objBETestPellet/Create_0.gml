mask = false;
destroy = !big;
comboSet = 0;

depthException = true;
if instance_exists(objBSoul) { depth = objBSoul.depth - 1; }

direction = point_direction(x, y, objBSoul.x, objBSoul.y);
speed = 2;
image_alpha = 0;