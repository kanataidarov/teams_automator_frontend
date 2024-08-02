#! /usr/bin/env bash

set -e

PROTOC_OPTS="-I./apis/ --dart_out=grpc:lib/grpc/"

rm -rf lib/grpc/
mkdir lib/grpc/

# shellcheck disable=SC2086
protoc $PROTOC_OPTS ./apis/teams_automator/*.proto