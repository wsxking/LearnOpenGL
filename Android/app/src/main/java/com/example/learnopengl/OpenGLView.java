package com.example.learnopengl;

import android.content.Context;
import android.opengl.GLSurfaceView;
import android.util.AttributeSet;
import android.util.Log;

import java.util.Date;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class OpenGLView extends GLSurfaceView {
    public static final  String TAG = "OpenGLView";

    public OpenGLView(Context context) {
        super(context);
    }

    public OpenGLView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
    }

    public void init() {
        setEGLContextClientVersion(2);
        GLSurfaceView.Renderer renderer = new GLSurfaceView.Renderer() {
            @Override
            public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
                Log.d(TAG, "onSurfaceCreated: " + Thread.currentThread());
                MainActivity.onSurfaceCreated(getContext().getAssets());
            }

            @Override
            public void onSurfaceChanged(GL10 gl10, int width, int height) {
                Log.d(TAG, "onSurfaceChanged: " + width + " " + height);
                MainActivity.onSurfaceChanged(width, height);
            }

            @Override
            public void onDrawFrame(GL10 gl10) {
                Log.d(TAG, "onDrawFrame: " + new Date().toString());
                MainActivity.onDrawFrame();
            }
        };
        setRenderer(renderer);
        setRenderMode(GLSurfaceView.RENDERMODE_WHEN_DIRTY);
    }
}
