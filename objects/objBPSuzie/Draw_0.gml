shader_set(shAdd);
shader_set_uniform_f_array(shader_get_uniform(shAdd, "addCol"),
	[color_get_red(aCol)/255, color_get_green(aCol)/255, color_get_blue(aCol)/255, 0]);
draw_self();
shader_reset();