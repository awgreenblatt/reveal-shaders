precision mediump float;
				 
// Built-in attributes
				  
attribute vec4 a_position;
attribute vec2 a_texCoord;
				   
// Built-in uniforms
				    
uniform mat4 u_projectionMatrix;
					 
					  
// Varyings
					   
varying vec2 v_uv;
					    
// Main
						 
void main()
{
	gl_Position = u_projectionMatrix * a_position;

	v_uv = a_texCoord;
}
						  
