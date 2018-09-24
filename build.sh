#!/bin/bash

set -e
set -u
set -o pipefail

ORG=garethjevans
TAG=$1

DIRS=`find . -name 'env.yaml'`
for DIR in ${DIRS}; do
  BUILD_DIR=$(dirname $(dirname ${DIR}))
  TEAM=$(basename ${BUILD_DIR})

  echo "TEAM=${TEAM}"

  pushd ${BUILD_DIR}
    if [ -f Dockerfile ]; then
      BUILD_TAG=${ORG}/jenkinsx:${TEAM}_${TAG}
      docker build -t ${BUILD_TAG} .
      docker push ${BUILD_TAG}
    fi

    if [ -f Chart.yaml ]; then
      sed -i "" -e "s/ImageTag: .*/ImageTag: \"${TEAM}_${TAG}\"/" values.yaml
      rm -fr charts
      helm init --client-only
      helm lint
      helm dependency update
      helm template .
    fi
  popd

done
