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
echo 'LS'
ls $APP
pack set-default-builder $BUILDER
$APP/mvnw package
pack build $REGISTRY/$PROJECT/$APP:$TAG -p $APP/target/sample-0.0.1-SNAPSHOT.jar
#docker push $REPOSITORY/$PROJECT/$APP:$TAG
echo "$TAG" > image/tag
docker save -o image/image.tar $REGISTRY/$PROJECT/$APP:$TAG