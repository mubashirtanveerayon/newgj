shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture; 
uniform float force : hint_range(0.0, 1.0) = 0.5; // Default higher
uniform float size : hint_range(0.0, 1.0) = 0.0;
uniform float thickness : hint_range(0.0, 0.5) = 0.1; // Thicker ring by default

void fragment() {
    float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
    vec2 scaled_uv = (UV - vec2(0.5)) / vec2(ratio, 1.0) + vec2(0.5);
    
    // Create the ring mask
    // "smoothstep" defines the softness. 
    // The smaller the difference between the two numbers, the sharper the edge.
    float outer_edge = smoothstep(size - 0.1, size, length(scaled_uv - vec2(0.5)));
    float inner_edge = smoothstep(size - thickness - 0.1, size - thickness, length(scaled_uv - vec2(0.5)));
    
    float mask = (1.0 - outer_edge) * inner_edge;
    
    // Multiply by 'force' to distort. 
    vec2 disp = normalize(UV - vec2(0.5)) * force * mask;
    
    // --- CHANGED PART ---
    // 1. Sample the distorted screen color
    vec4 screen_color = texture(screen_texture, SCREEN_UV - disp);
    
    // 2. Define purple (Red 0.6, Green 0.1, Blue 1.0)
    vec4 purple_color = vec4(0.6, 0.1, 1.0, 1.0);
    
    // 3. Mix original color with purple based on the mask
    // 'mask * 0.5' makes it semi-transparent (0.5 strength) so you can still see the game
    COLOR = mix(screen_color, purple_color, mask * 0.08);
}