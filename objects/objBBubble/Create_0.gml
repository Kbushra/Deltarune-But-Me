depthException = true;
depth = -99999;

image_xscale = 0.5;
image_yscale = 0.5;

page = 0;
pos = 1;
charCounter = 0;

col = c_black;
delay = 0;

currChar[0] = "";

var temp = [];
array_copy(temp, 0, _text, 0, array_length(_text));
_text = temp;

breakCount = 9;

multLines = false;

for (var i = 0; i < array_length(_text); i++)
{ if string_length(_text[i]) > breakCount { image_index = 1; } }