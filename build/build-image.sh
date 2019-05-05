#!/bin/bash
set -x -e -u
pack version
docker
env
source /opt/resource/common.sh
sanitize_cgroups
start_docker \
	"$insecure_registries" \
  "$registry_mirror"

pack set-default-builder $BUILDER
pack build $REPOSITORY/$APP:$TAG -p $APP