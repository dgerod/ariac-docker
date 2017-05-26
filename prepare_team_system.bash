#!/usr/bin/env bash

TEAM_NAME=$1

#TODO: add ROS distro as an argument.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Preparing the team system setup for team '${TEAM_NAME}"

${DIR}/ariac-competitor/build_competitor_image.bash ${TEAM_NAME}