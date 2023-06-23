#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

const vec3 weight = vec3(0.2989,  0.5870, 0.1140);

void mainImage()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
	vec4 color = flixel_texture2D(bitmap, uv);

    vec3 tex_sample = texture(iChannel0, uv).rgb;
    
    float greyscale = dot(tex_sample, weight);
	
	color.rgb = vec3(greyscale, greyscale, greyscale);

    fragColor = color;
}