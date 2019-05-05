#!/bin/bash
set -x 
pack version
docker
env
cd $APP
ls