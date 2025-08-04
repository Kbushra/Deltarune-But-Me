//By default all objects have depth according to this
with (all) { if !variable_instance_exists(id, "depthException") { depth = -bbox_bottom; } }
if keyboard_check_pressed(vk_f4) { window_set_fullscreen(!window_get_fullscreen()); }