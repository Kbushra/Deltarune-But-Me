global.l = keyboard_check(ord("A")) || keyboard_check(vk_left);
global.r = keyboard_check(ord("D")) || keyboard_check(vk_right);
global.u = keyboard_check(ord("W")) || keyboard_check(vk_up);
global.d = keyboard_check(ord("S")) || keyboard_check(vk_down);

global.lP = keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left);
global.rP = keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right);
global.uP = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
global.dP = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down);

global.confirm = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);
global.cancel = keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift);
global.cancelH = keyboard_check(ord("X")) || keyboard_check(vk_shift);
global.menu = keyboard_check_pressed(ord("C")) || keyboard_check_pressed(vk_control);

for (var i = 0; i < array_length(global.inventory); i++)
{
	if global.inventory[i] == -1 { global.invLength = i; break; }
	if i >= array_length(global.inventory) - 1 { global.invLength = 12; }
}