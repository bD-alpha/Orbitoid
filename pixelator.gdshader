shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture, filter_linear;

const vec3 NUM_COLORS = vec3(11., 7., 3.);

const int[] BAYER = {
 0, 32,  8, 40,  2, 34, 10, 42, /* 8x8 Bayer ordered dithering */
48, 16, 56, 24, 50, 18, 58, 26, /* pattern. Each input pixel */
12, 44,  4, 36, 14, 46,  6, 38, /* is scaled to the 0..63 range */
60, 28, 52, 20, 62, 30, 54, 22, /* before looking in this table */
 3, 35, 11, 43,  1, 33,  9, 41, /* to determine the action. */
51, 19, 59, 27, 49, 17, 57, 25,
15, 47,  7, 39, 13, 45,  5, 37,
63, 31, 55, 23, 61, 29, 53, 21}; 

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	ivec2 fragCoord = ivec2(floor(SCREEN_UV / SCREEN_PIXEL_SIZE / 2.) * 2.0);
	vec2 uv =  vec2(fragCoord) * SCREEN_PIXEL_SIZE;
	
	vec3 rgb = texture(screen, uv).rgb * 8.;
	vec3 hsv = rgb2hsv(rgb) * NUM_COLORS;
	hsv += (float(BAYER[(fragCoord.y % 8) * 8 + fragCoord.x % 8]) + NUM_COLORS) / 64.0  - 0.5;
	
	COLOR.rgb = hsv2rgb(round(hsv)  / NUM_COLORS) / 8.;
	COLOR.a = 1.0;
}
