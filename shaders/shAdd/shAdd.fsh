//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 addCol;

void main()
{
    vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	col += addCol;
	gl_FragColor = col;
}