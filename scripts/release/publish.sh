#!/usr/bin/env bash

set -e

PATH=${BASH_SOURCE%/*}:$PATH; . publish-utils.sh;

declare GIT_BIN_PATH=$(which git);
declare NPM_BIN_PATH=$(which npm);

if [[ -z "${GIT_BIN_PATH}" ]]; then
    echo "Failed to locate the git bin" && exit 1;
fi;

if [[ -z "${NPM_BIN_PATH}" ]]; then
    echo "Failed to locate the npm bin" && exit 1;
fi;

if [[ $(git_fetch_tags) -ne 0 ]]; then
    echo "Failed to fetch the git tags" && exit 1;
fi;

declare NEXT_VERSION="$(git_get_next_version)"

if [[ $(npm_version ${NEXT_VERSION}) -ne 0 ]]; then
    echo "Failed to version the package" && exit 1;
fi;

if [[ $(npm_publish) -ne 0 ]]; then
    echo "Failed to publish the package" && exit 1;
fi;

if [[ $(git_push_tags) -ne 0 ]]; then
    echo "Failed to push the generated git tags" && exit 1;
fi;

echo "Package publish finished successfully" && exit 0;
