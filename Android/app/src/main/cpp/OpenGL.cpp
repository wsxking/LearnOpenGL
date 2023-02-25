//
// Created by WSX on 2023/2/25.
//

#include "OpenGL.h"
#if __ANDROID__
#include <GLES2/gl2.h>
#endif

void OpenGL::onSurfaceCreated() {

}

void OpenGL::onSurfaceChanged(int width, int height) {

}

void OpenGL::onDrawFrame() {
    glClearColor(0.5, 0.5, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
}