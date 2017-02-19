#!/usr/bin/env bash

JDK7="/usr/lib/jvm/java-7-openjdk-amd64"
#export PYTHON=/usr/bin/python

mkdir -p ./build/linux

g++ \
-I./node \
-I./node/deps/v8 \
-I./node/deps/v8/include \
-I./node/src \
-I ${JDK7}/include/ \
-I ${JDK7}/include/linux  \
./jni/com_eclipsesource_v8_V8Impl.cpp -std=c++11 -fPIC -shared \
-o ./build/linux/libj2v8_linux_x86_64.so \
-Wl,--whole-archive \
./node/out/Release/libnode.a \
-Wl,--no-whole-archive \
-Wl,--start-group \
  ./node/out/Release/libv8_libbase.a \
  ./node/out/Release/libv8_libplatform.a \
  ./node/out/Release/libv8_base.a \
  ./node/out/Release/libv8_nosnapshot.a \
  ./node/out/Release/libuv.a \
  ./node/out/Release/libopenssl.a \
  ./node/out/Release/libhttp_parser.a \
  ./node/out/Release/libgtest.a \
  ./node/out/Release/libzlib.a \
  ./node/out/Release/libcares.a \
-Wl,--end-group \
-lrt -D NODE_COMPATIBLE=1