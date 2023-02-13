precision highp float;

attribute vec2 aPosition;
attribute vec2 aCoord;

varying vec2 vCoord;

void main() {
    gl_Position = vec4(aPosition, 0.0, 1.0);
    vCoord = aCoord;
}
