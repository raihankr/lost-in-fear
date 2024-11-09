//Vignette Shader

//see more info about shaders here --> https://github.com/TechnoLukas/My-favourite-shaders-links
//ported with https://github.com/jayaarrgh/shadertoy2godot (with some hand fixing)
//on shadertoy https://www.shadertoy.com/view/WsGSD3

shader_type canvas_item;
uniform float inner_offset = 0.0;
uniform float outer_offset = 0.0;

void fragment() {
	COLOR = vec4(vec3(0), outer_offset + abs(UV.x * 2.0 - 1.0) / inner_offset - 1.0 / inner_offset + 1.0);
}