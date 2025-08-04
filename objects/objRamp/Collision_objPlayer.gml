if image_angle == 0
{
	if other.dir == "D" { other.x += other.spd - other.hSpd; }
	if other.dir == "L" { other.y -= other.spd + other.vSpd; }
}

if image_angle == 90
{
	if other.dir == "D" { other.x -= other.spd + other.hSpd; }
	if other.dir == "R" { other.y -= other.spd + other.vSpd; }
}

if image_angle == 180
{
	if other.dir == "U" { other.x -= other.spd + other.hSpd; }
	if other.dir == "R" { other.y += other.spd - other.vSpd; }
}

if image_angle == 270
{
	if other.dir == "U" { other.x += other.spd - other.hSpd; }
	if other.dir == "L" { other.y += other.spd - other.vSpd; }
}