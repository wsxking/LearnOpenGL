//
//  OpenGLView.m
//  LearnOpenGL
//
//  Created by WangShunXing on 2023/2/25.
//

#import "OpenGLView.h"
#include "OpenGL.h"

@implementation OpenGLView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        [EAGLContext setCurrentContext:self.context];
        
        NSLog(@"[OpenGLView] onSurfaceCreated");
        NSString *assets = [NSBundle.mainBundle pathForResource:@"assets" ofType:nil];
        OpenGL::onSurfaceCreated(std::string(assets.UTF8String));
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    int width = self.bounds.size.width * self.contentScaleFactor;
    int height = self.bounds.size.height * self.contentScaleFactor;
    
    NSLog(@"[OpenGLView] onSurfaceChanged: %d %d", width, height);
    OpenGL::onSurfaceChanged(width, height);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    NSLog(@"[OpenGLView] onDrawFrame");
    OpenGL::onDrawFrame();
}

@end
