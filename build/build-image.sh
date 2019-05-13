#!/bin/bash
set -x -e -u
pack version
#docker
env
source /opt/resource/common.sh
sanitize_cgroups
start_docker \
	"$REGISTRY" \
  ""
#log_in "$HARBOR_USER" "$HARBOR_PASS" "$REPOSITORY"
pack set-default-builder $BUILDER
pack build $REGISTRY/$PROJECT/$APP:$TAG -p $APP
#docker push $REPOSITORY/$PROJECT/$APP:$TAG
echo "$TAG" > image/tag
docker save -o image/image.tar $REGISTRY/$PROJECT/$APP:$TAG