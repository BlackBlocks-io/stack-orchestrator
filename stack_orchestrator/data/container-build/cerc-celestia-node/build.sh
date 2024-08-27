#!/usr/bin/env bash
# Build a local version of the celestiaorg/celestia-node image
source ${CERC_CONTAINER_BASE_DIR}/build-base.sh
docker build -t cerc/celestia-node:local -f ${CERC_REPO_BASE_DIR}/celestia-node/docker/Dockerfile ${build_command_args} ${CERC_REPO_BASE_DIR}/celestia-node
