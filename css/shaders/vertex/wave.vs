/*
Copyright 2012 Adobe Systems, Incorporated
This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License http://creativecommons.org/licenses/by-nc-sa/3.0/ .
Permissions beyond the scope of this license, pertaining to the examples of code included within this work are available at Adobe http://www.adobe.com/communities/guidelines/ccplus/commercialcode_plus_permission.html .
*/

precision mediump float;

attribute vec4 a_position;
attribute vec2 a_texCoord;

uniform mat4 u_projectionMatrix;

// This uniform values are passed in using CSS.
uniform float angle;
uniform float power;

varying vec2 v_texCoord;

const float PI = 3.1416;
const float degToRad = PI / 180.0;

mat4 xRot(float rads) {
    mat4 rotMat = mat4(
	    1.0, 0.0, 0.0, 0.0,
	    0.0, cos(rads), -sin(rads), 0.0,
	    0.0, sin(rads), cos(rads), 0.0,
	    0.0, 0.0, 0.0, 1.0);
    return rotMat;
}
	
mat4 zRot(float rads) {
    mat4 rotMat = mat4(
	    cos(rads), -sin(rads), 0.0, 0.0,
	    sin(rads), cos(rads), 0.0, 0.0,
	    0.0, 0.0, 0.0, 0.0,
	    0.0, 0.0, 0.0, 1.0);
    return rotMat;
}
	

void main()
{
    v_texCoord = a_texCoord;
    vec4 pos = a_position;

    mat4 txf = zRot(pow((-1.0*pos.y+0.5), power) * angle * degToRad);

    gl_Position = u_projectionMatrix * txf * pos;
}
