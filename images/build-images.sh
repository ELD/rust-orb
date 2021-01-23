#!/usr/bin/env bash

ORG=edattore
IMAGE_NAME=rust
RUST_VERSIONS=(1.49.0-default 1.49.0-minimal nightly-default nightly-minimal)
EXTRA_TOOLS=(clippy rustfmt)
LATEST=($(echo "${RUST_VERSIONS[0]}" | tr "-" " "))

function build_image() {
    local org=$1
    local image_name=$2
    local rust_version=$3
    local rust_profile=${4:-}
    local version_tag="${rust_version}"

    if [[ !rust_profile = "" ]]; then
        version_tag="${rust_version}-${rust_profile}"
    fi

    docker build -t ${org}/${image_name}:${version_tag} . \
        --build-arg RUST_VERSION=${rust_version} \
        --build-arg RUST_PROFILE=${rust_profile}
}

for version in ${RUST_VERSIONS[@]}; do
    version_profile=($(echo "${version}" | tr "-" " "))
    if [[ ${version_profile[1]} = "default" ]]; then
        echo "Building tag: ${version_profile[0]}"
        build_image $ORG $IMAGE_NAME ${version_profile[0]}

        docker push ${ORG}/rust:${version_profile[0]}
    else
        echo "Building tag: ${version_profile[0]}-${version_profile[1]}"
        build_image $ORG $IMAGE_NAME ${version_profile[0]} ${version_profile[1]}
        
        docker push ${ORG}/rust:${version_profile[0]}-${version_profile[1]}
    fi
done

docker tag ${ORG}/rust:${LATEST[0]} ${ORG}/rust:latest
docker push ${ORG}/rust:latest
