precision mediump float;

varying vec2 v_uv;

uniform float time;
uniform vec2 resolution;

/*
 * This shader is derived from the Plasma shader developed by Viktor Korsun
 * as seen in Shader Toy.
 */


// Main

void main()
{
	float x = gl_FragCoord.x;
	float y = gl_FragCoord.y;
	float mov0 = x+y+cos(sin(time)*2.)*100.+sin(x/100.)*1000.;
	float mov1 = y / resolution.y / 0.2 + time;
	float mov2 = x / resolution.x / 0.2;
	float c1 = abs(sin(mov1+time)/2.+mov2/2.-mov1-mov2+time);
	float c2 = abs(sin(c1+sin(mov0/1000.+time)+sin(y/40.+time)+sin((x+y)/100.)*3.));
	float c3 = abs(sin(c2+cos(mov1+mov2+c2)+cos(mov2)+sin(x/1000.)));

	css_MixColor = vec4( c1,c2,c3,1.0);
}
