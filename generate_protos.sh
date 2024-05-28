#! /usr/bin/env bash

set -e

PROTOC_OPTS="-I./apis/ --dart_out=grpc:lib/grpc/"

rm -rf lib/grpc/
mkdir lib/grpc/

protoc $PROTOC_OPTS ./apis/interview_automator/*.proto