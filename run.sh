#!/bin/bash

TAG="${1:-openroad/orfs:v3.0-4020-g93a69fb95}"

echo "Running OpenROAD flow with tag: ${TAG}"

docker run --rm -it \
    -u "$(id -u "${USER}")":"$(id -g "${USER}")" \
    -v "$(pwd)/flow:/OpenROAD-flow-scripts/flow" \
    -e DISPLAY="${DISPLAY}" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "${HOME}/.Xauthority:/.Xauthority" \
    --network host \
    --security-opt seccomp=unconfined \
    "${TAG}"
