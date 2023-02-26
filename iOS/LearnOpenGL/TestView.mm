//
//  TestView.m
//  LearnOpenGL
//
//  Created by TomWang on 2023/2/6.
//

#import "TestView.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import "Shader.hpp"

@interface TestView () <GLKViewDelegate>
@property (nonatomic, strong) GLKView *glkView;
@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _glkView = [[GLKView alloc] initWithFrame:frame context:[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3]];
        _glkView.delegate = self;
        [self addSubview:_glkView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.glkView.frame = self.bounds;
    [self.glkView display];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 1, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    
    NSString *vCode = [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"vertex.glsl" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    NSString *fCode = [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"fragment.glsl" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    Shader shader(vCode.UTF8String, fCode.UTF8String);
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
    
    setTexture();
    shader.setInt("texture", 0);
    
    setTexture2();
    shader.setInt("texture2", 1);
    
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

void setTexture2() {
    GLuint texture = 0;
    glGenTextures(1, &texture);
    
    // 指定为当前要操作的纹理对象
    glActiveTexture(GL_TEXTURE0 + 1);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    // 设置纹理环绕和纹理过滤方式
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    // 将图片数据拷贝给纹理对象(拷贝到显存)
    GLuint format = GL_RGBA;
    int width = 2;
    int height = 2;
    unsigned char data[16] = {
        0x0, 0x0, 0xFF, 0xFF,
        0xFF, 0xFF, 0x0, 0xFF,
        0xFF, 0x0, 0x0, 0xFF,
        0x0, 0xFF, 0xFF, 0xFF,
    };
    glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
}

@end
