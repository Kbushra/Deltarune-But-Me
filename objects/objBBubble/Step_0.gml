var next = global.confirm || global.menu;
var skip = global.cancel || global.menu;

if pos >= string_length(_text[page]) && next { page++; pos = 1; }
else if skip { pos = string_length(_text[page]) }

global.bubbleSfx = false;

if page >= array_length(_text)
{
	if origin != -1 { origin.bubbleEnd = true; }
	instance_destroy();
	exit;
}

multLines = string_length(_text[page]) > breakCount;