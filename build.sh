#!/bin/bash

docker run \
    --rm \
    --privileged \
    -v $(realpath ./):/tmp/src \
    -v $(realpath ./):/tmp/dockerfile \
    -v $HOME/.docker:/root/.docker \
    --env DOCKER_BUILDKIT=1 \
    --entrypoint buildctl-daemonless.sh \
    moby/buildkit:master \
    build \
    --frontend dockerfile.v0 \
    --local context=/tmp/src \
    --local dockerfile=/tmp/dockerfile \
    --opt build-arg:BUILD_COMMIT_ID=551f997186da5c748bc16e6b4337691669416e4b \
    --opt build-arg:BUILD_COMMIT_DATE=2020-05-20T06:57:44Z \
    --opt build-arg:BUILD_DATE=2020-05-25T06:53:02Z \
    --opt build-arg:BUILD_ENV=${ENVIRONMENT} \
    --export-cache type=local,dest=/tmp/website-buildcache,mod=max
