#!/usr/bin/env bash

cd ..

git clone https://github.com/nodejs/node.git
cd node
git checkout v6.1.0
./configure --enable-static
make
