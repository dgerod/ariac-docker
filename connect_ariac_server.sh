#!/usr/bin/env bash

set -e

CONTAINER_NAME="ariac-server-system"
docker container exec -it ${CONTAINER_NAME} bash
