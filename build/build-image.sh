#!/bin/bash
set -x -e -u
pack version
docker
env
source /opt/resource/common.sh

docker run --privileged -d docker:dind

pack set-default-builder $BUILDER
pack build $REPOSITORY/$APP:$TAG -p $APP