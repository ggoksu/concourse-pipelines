#!/bin/bash
set -x -e -u
pack version
docker
env
source /opt/resource/common.sh
start_docker 3 3 "" ""
pack set-default-builder $BUILDER
pack build $REPOSITORY/$APP:$TAG -p $APP