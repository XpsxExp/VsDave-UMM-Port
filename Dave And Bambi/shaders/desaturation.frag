#pragma header

vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

//https://www.shadertoy.com/view/lsdXDH
vec4 generic_desaturate(vec3 color, float factor)
{
	vec3 lum = vec3(0.299, 0.587, 0.114);
	vec3 gray = vec3(dot(lum, color));
	return vec4(mix(color, gray, factor), flixel_texture2D(iChannel0, uv).a);
}


void mainImage()
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	fragColor = generic_desaturate(texture(iChannel0, uv).rgb, 1.0);
}