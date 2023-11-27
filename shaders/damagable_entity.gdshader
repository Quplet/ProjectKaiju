shader_type canvas_item;

uniform float red_shift_ammount;

void fragment() {
	COLOR.rgb = vec3(min(COLOR.r + red_shift_ammount, 1.0), COLOR.g, COLOR.b);
}
