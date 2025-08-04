if side == 0 { x = lerp(x, 25, 0.15); }
else { x = lerp(x, 295, 0.15); }

velo += grav;
y += velo;
if y > originY + 5 && alarm[0] > 0 { velo = -4 + 2*bounce; bounce++; }
y = clamp(y, 0, originY + 5);

if alarm[0] > 0 { image_yscale = lerp(image_yscale, 1, 0.15); }
else { image_yscale += 0.1; image_alpha -= 0.1; }

if image_alpha <= 0 { instance_destroy(); }