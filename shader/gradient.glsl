extern number time;
extern number fillRatio;

vec4 effect(vec4 color, Image texture, vec2 texCoords, vec2 screenCoords) {
    // Discard any part of the bar beyond the current fill
    if (texCoords.x > fillRatio) {
        discard;
    }

    // Gradient from yellow to green across full bar width
    vec3 yellow = vec3(1.0, 0.2, 0.0);
    vec3 green = vec3(0.0, 1.0, 1.0);
    vec3 baseColor = mix(yellow, green, texCoords.x);


    float wobble = sin(texCoords.y * 10.0 + time) * 0.02;
    float offset = texCoords.x + wobble;

    float ripple = sin(offset * 40.0 - time * 3.0 + texCoords.y * 20.0);
    float blend = smoothstep(0.8, 0.0, texCoords.x);
    float brightness = ripple * 0.3 * blend;

    baseColor = mix(baseColor, baseColor + vec3(brightness), 0.5 * blend);

    return vec4(baseColor, 1.0);
}