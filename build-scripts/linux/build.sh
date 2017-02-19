#!/usr/bin/env bash

JDK7=${JAVA_HOME:-"/usr/lib/jvm/java-7-openjdk-amd64"}
NODE=./node
#NODE=/home/vagrant/node

mkdir -p ./build/linux

g++ \
-I${NODE} \
-I${NODE}/deps/v8 \
-I${NODE}/deps/v8/include \
-I${NODE}/src \
-I ${JDK7}/include/ \
-I ${JDK7}/include/linux  \
./jni/com_eclipsesource_v8_V8Impl.cpp -std=c++11 -fPIC -shared \
-o ./build/linux/libj2v8_linux_x86_64.so \
-Wl,--whole-archive \
${NODE}/out/Release/libnode.a \
-Wl,--no-whole-archive \
-Wl,--start-group \
  ${NODE}/out/Release/libv8_libbase.a \
  ${NODE}/out/Release/libv8_libplatform.a \
  ${NODE}/out/Release/libv8_base.a \
  ${NODE}/out/Release/libv8_nosnapshot.a \
  ${NODE}/out/Release/libuv.a \
  ${NODE}/out/Release/libopenssl.a \
  ${NODE}/out/Release/libhttp_parser.a \
  ${NODE}/out/Release/libgtest.a \
  ${NODE}/out/Release/libzlib.a \
  ${NODE}/out/Release/libcares.a \
-Wl,--end-group \
-lrt -D NODE_COMPATIBLE=1