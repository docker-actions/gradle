#!/bin/bash

set -Eeuo pipefail

docker_org="${1}"
tag="${2}"

build_args=''
for ba in $BUILD_ARGS; do
  build_args="${build_args} --build-arg ${ba}=${!ba}"
done

sed 's/${JAVA_VERSION}/'${JAVA_VERSION}'/' Dockerfile.template > Dockerfile

image_name=''
if [ "x${tag}" = "xlatest" ]; then
  image_name="${docker_org}/gradle:${tag}-java${JAVA_TAG}"
else
  image_name="${docker_org}/gradle:${GRADLE_VERSION}-java${JAVA_TAG}-${tag}"
fi
docker build ${build_args} -t ${image_name} .