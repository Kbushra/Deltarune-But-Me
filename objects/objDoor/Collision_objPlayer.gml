if instance_exists(objTransition) { exit; }
instance_create_layer(x, y, "Instances", objTransition, { targRoom: tRoom, targX: tX, targY: tY });