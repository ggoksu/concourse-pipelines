#!/bin/bash
set -x -e -u
pack version
docker
env
source /opt/resource/common.sh

certs_to_file "$ca_certs"
set_client_certs "$client_certs"
sanitize_cgroups
start_docker \
	"" \
  ""
#log_in "$username" "$password" "$registry"

pack set-default-builder $BUILDER
pack build $REPOSITORY/$APP:$TAG -p $APP