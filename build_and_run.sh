#!/bin/bash
docker build -t kfs .
xhost +local:docker
docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --privileged \
  -v $(pwd):/kfs \
  kfs
