#!/bin/bash
set -e

NDK="/opt/android/ndk-12b"
JWL_OUTPUT_DIR="/mnt/meps/JWLibrary/JWLibrary/Android/native"
#JWL_OUTPUT_DIR="/home/csnelson/dept/JWLibrary/JWLibrary/Android/native"

# Arrange the V8 libraries into their correct platform folders
pushd jni

rm -rf v8
mkdir -p v8/armeabi v8/armeabi-v7a v8/arm64-v8a v8/x86 v8/x86_64
cp -f ${JWL_OUTPUT_DIR}/arm/* v8/armeabi/
cp -f ${JWL_OUTPUT_DIR}/arm/* v8/armeabi-v7a/
cp -f ${JWL_OUTPUT_DIR}/arm64/* v8/arm64-v8a/
cp -f ${JWL_OUTPUT_DIR}/x86/* v8/x86/
cp -f ${JWL_OUTPUT_DIR}/x86_64/* v8/x86_64/
cp -rf ${JWL_OUTPUT_DIR}/include v8/

# Build the JNI libraries
${NDK}/ndk-build

# Return to base
popd

# Prepare to package them into the AAR
mkdir -p src/main/jniLibs
cp -vrf libs/* src/main/jniLibs/

# Make the AAR
./gradlew assemble

# Copy the output
mkdir -p ${JWL_OUTPUT_DIR}/j2v8
cp -vf build/outputs/aar/workspace-release.aar ${JWL_OUTPUT_DIR}/j2v8/j2v8.aar
