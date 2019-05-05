#!/bin/bash
set -x -e -u
pack version
docker
env
pack set-default-builder $BUILDER
pack build $REPOSITORY/$APP:$TAG -p $APP