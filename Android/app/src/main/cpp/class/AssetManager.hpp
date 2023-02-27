//
//  AssetManager.hpp
//  LearnOpenGL
//
//  Created by TomWang on 2023/2/27.
//

#ifndef AssetManager_h
#define AssetManager_h

#include <stdio.h>
#include <string>

#if __ANDROID__
// 安卓资源在apk包中没有绝对路径,使用JNI的AAssetManager
#include <android/asset_manager_jni.h>
typedef AAssetManager *AppAssetManager;

#elif __APPLE__
// iOS资源有绝对路径,使用C++标准文件流
#include <fstream>
typedef std::string AppAssetManager;
#endif

class AssetManager {
public:
    static inline AppAssetManager appAssetManager;

#if __ANDROID__
    static std::string readFile(const std::string &path) {
        if (!appAssetManager || !path.size()) {
            return "";
        }
        // 1. 打开文件
        AAsset *asset = AAssetManager_open(appAssetManager, path.c_str(), AASSET_MODE_UNKNOWN);
        if (!asset) {
            return "";
        }
        // 2. 获取文件大小
        int length = (int)AAsset_getLength(asset);
        // 3. 读取文件字节
        std::string bytes(length, 0);
        AAsset_read(asset, (char *)bytes.c_str(), length);
        // 4. 关闭文件
        AAsset_close(asset);
        return bytes;
    }
    
#elif __APPLE__
    static std::string readFile(const std::string &path) {
        if (!appAssetManager.size() || !path.size()) {
            return "";
        }
        // 1. 打开文件
        std::string fullPath = appAssetManager + "/" + path;
        std::ifstream inputFile(fullPath, std::ios::in | std::ios::binary);
        if (!inputFile) {
            return "";
        }
        // 2. 获取文件大小
        inputFile.seekg(0, std::ios::end);
        int length = (int)inputFile.tellg();
        inputFile.seekg(0, std::ios::beg);
        // 3. 读取文件字节
        std::string bytes(length, 0);
        inputFile.read((char *)bytes.c_str(), length);
        // 4. 关闭文件
        inputFile.close();
        return bytes;
    }
#endif
};

#endif /* AssetManager_h */
