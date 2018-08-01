#!/bin/bash

set -x

GOPATH=$(go env GOPATH)
PACKAGE_NAME=github.com/google/go-github/github
REPO_ROOT="$GOPATH/src/$PACKAGE_NAME"
DOCKER_REPO_ROOT="/go/src/$PACKAGE_NAME"
DOCKER_CODEGEN_PKG="/go/src/k8s.io/code-generator"

rm -rf "$REPO_ROOT"/*generated.deepcopy.go

docker run --rm -ti -u $(id -u):$(id -g) \
  -v "$REPO_ROOT":"$DOCKER_REPO_ROOT" \
  -w "$DOCKER_REPO_ROOT" \
  appscode/gengo:release-1.11 "$DOCKER_CODEGEN_PKG"/generate-internal-groups.sh deepcopy \
  $PACKAGE_NAME $PACKAGE_NAME $PACKAGE_NAME ":"
