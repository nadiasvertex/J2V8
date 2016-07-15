#!/bin/bash
set -e

NDK="/opt/android/ndk-r12b"
#JWL_OUTPUT_DIR="/mnt/meps/JWLibrary/JWLibrary/Android"
JWL_OUTPUT_DIR="/home/csnelson/dept/JWLibrary/JWLibrary/Android/native"

# Put Android NDK into the path
#export PATH=/opt/android/ndk-12b/:$PATH

# Arrange the V8 libraries into their correct platform folders
pushd jni
rm -rf v8
mkdir -p v8/armeabi-v7a v8/arm64-v8a v8/x86
cp -f ${JWL_OUTPUT_DIR}/arm/* v8/armeabi-v7a/
cp -f ${JWL_OUTPUT_DIR}/arm64/* v8/arm64-v8a/
cp -f ${JWL_OUTPUT_DIR}/x86/* v8/x86/
cp -rf ${JWL_OUTPUT_DIR}/include v8/

# Build the JNI libraries
${NDK}/ndk-build

# Return to base
popd
