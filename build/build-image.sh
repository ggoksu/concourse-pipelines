#!/bin/bash
set -x -e -u
pack version
docker
env
source /opt/resource/common.sh
sanitize_cgroups
start_docker \
	"" \
  ""

pack set-default-builder $BUILDER
pack build $REPOSITORY/$APP:$TAG -p $APP
docker save -o image/image.tar $REPOSITORY/$APP:$TAG