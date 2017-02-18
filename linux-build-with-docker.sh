#!/bin/bash

docker rm -v j2v8-linux
docker build --rm=true --no-cache -t "eclipsesource/j2v8-linux-build" ./build-scripts/linux/
docker run --name j2v8-linux eclipsesource/j2v8-linux-build
#docker cp j2v8-linux:/data/v8_3_26/out .
