#!/bin/bash
set -x -e -u
pack version
docker
env
entrypoint.sh
pack set-default-builder $BUILDER
pack build $REPOSITORY/$APP:$TAG -p $APP