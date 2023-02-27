//
// Created by WSX on 2023/2/25.
//

#include "OpenGL.h"
#if __ANDROID__
#include <GLES2/gl2.h>
#elif __APPLE__
#include <OpenGLES/ES2/gl.h>
#endif
#include "class/Shader.hpp"

void OpenGL::onSurfaceCreated(AppAssetManager appAssetManager) {
    AssetManager::appAssetManager = appAssetManager;
}

void OpenGL::onSurfaceChanged(int width, int height) {

}

void OpenGL::onDrawFrame() {
    glClearColor(0.5, 0.5, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    std::string vCode = AssetManager::readFile("vertex.glsl");
    std::string fCode = AssetManager::readFile("fragment.glsl");
    Shader shader(vCode.c_str(), fCode.c_str());
    shader.use();
    
    float point[8] = {
        -0.5, 0.5,
        0.5, 0.5,
        0.5, -0.5,
        -0.5, -0.5
    };
    GLuint vBuffer = 0;
    glGenBuffers(1, &vBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(point), point, GL_STATIC_DRAW);
    
    GLuint positionLoc = glGetAttribLocation(shader.ID, "aPosition");
    glEnableVertexAttribArray(positionLoc);
    glVertexAttribPointer(positionLoc, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void *)0);
    
    float coord[8] = {
        0, 0,
        1, 0,
        1, 1,
        0, 1
    };
    GLuint tBuffer = 0;
    glGenBuffers(1, &tBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, tBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(coord), coord, GL_STATIC_DRAW);
    
    GLuint coordLoc = glGetAttribLocation(shader.ID, "aCoord");
    glEnableVertexAttribArray(coordLoc);
    glVertexAttribPointer(coordLoc, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void *)0);
    
    void setTexture();
    setTexture();
    shader.setInt("texture", 0);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}

void setTexture() {
    GLuint texture = 0;
    glGenTextures(1, &texture);
    
    // 指定为当前要操作的纹理对象
    glActiveTexture(GL_TEXTURE0 + 0);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    // 设置纹理环绕和纹理过滤方式
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    // 将图片数据拷贝给纹理对象(拷贝到显存)
    GLuint format = GL_RGBA;
    int width = 2;
    int height = 2;
    unsigned char data[16] = {
        0xFD, 0x00, 0x00, 0xFF,  0x00, 0xFF, 0xFF, 0xFF,
        0x00, 0x00, 0xFF, 0xFF,  0xFF, 0xFF, 0x00, 0xFF,
    };
    glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
}
