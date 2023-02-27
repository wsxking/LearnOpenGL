precision highp float;

uniform sampler2D texture;
uniform sampler2D texture2;

varying vec2 vCoord;

void main() {
//    vec4 color2 = texture2D(texture2, vCoord).rgba;
    vec4 color = texture2D(texture, vCoord).rgba;
    if (int(color.r * 255.0) == 0xFD) {
        gl_FragColor = vec4(1, 1, 1, 1);
    } else {
        gl_FragColor = color;
    }
}
