shader_type canvas_item;

uniform bool enabled=false;
uniform float flash_strength=20;

void fragment() {
	vec4 pixelColor = texture(TEXTURE,UV);
	if (pixelColor.a>0.1 && enabled){
		if (sin(TIME*flash_strength) > 0.0){
			COLOR=vec4(1.0,1.0,1.0,pixelColor.a);
		}

	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
