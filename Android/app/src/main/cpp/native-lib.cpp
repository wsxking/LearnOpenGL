#if __ANDROID__
#include <jni.h>
#include "OpenGL.h"

extern "C" JNIEXPORT void JNICALL
Java_com_example_learnopengl_MainActivity_onSurfaceCreated(JNIEnv *env, jclass clazz) {
    OpenGL::onSurfaceCreated();
}
extern "C" JNIEXPORT void JNICALL
Java_com_example_learnopengl_MainActivity_onSurfaceChanged(JNIEnv *env, jclass clazz, jint width, jint height) {
    OpenGL::onSurfaceChanged(width, height);
}
extern "C" JNIEXPORT void JNICALL
Java_com_example_learnopengl_MainActivity_onDrawFrame(JNIEnv *env, jclass clazz) {
    OpenGL::onDrawFrame();
}

#endif