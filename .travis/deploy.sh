#!/bin/bash

set -Eeuo pipefail

docker_org="${1}"
tag="${2}"

sed 's/${JAVA_VERSION}/'${JAVA_VERSION}'/' Dockerfile.template > Dockerfile

image_name=''
if [ "x${tag}" = "xlatest" ]; then
  image_name="${docker_org}/gradle:${tag}-java${JAVA_TAG}"
else
  image_name="${docker_org}/gradle:${GRADLE_VERSION}-java${JAVA_TAG}-${tag}"
fi
docker push ${image_name}