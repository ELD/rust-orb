#!/usr/bin/env bash

ORG=edattore
RUST_VERSIONS=(1.49.0 nightly)
LATEST=${RUST_VERSIONS[0]}

for version in ${RUST_VERSIONS[@]}; do
    docker build -t ${ORG}/rust:${version} . --build-arg RUST_VERSION=${version}
    docker push ${ORG}/rust:${version}
done

docker tag ${ORG}/rust:${LATEST} ${ORG}/rust:latest
