#!/usr/bin/env bash

set -e

declare -x GIT_BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
declare -x GIT_EVERGREEN_BRANCHES=( master release );

function contains() {
    declare -n local HAYSTACK_VAR_NAME="$1"
    NEEDLE=$2

    for INDEX in "${!HAYSTACK_VAR_NAME[@]}"
    do
        if [[ "${HAYSTACK_VAR_NAME["$INDEX"]}" == "$NEEDLE" ]]
        then
          return 0
        fi
    done
    return 1
}

function semver_call() {
    echo $(PATH=${BASH_SOURCE%/*}:$PATH . semver-tool.sh $@);
}

function semver_build_prerel() {
    if contains GIT_EVERGREEN_BRANCHES "${GIT_BRANCH_NAME}"; then
        echo "";
    else
        echo "${GIT_BRANCH_NAME:0:20}"
    fi
}

function semver_get_major() {
    declare VERSION="${1}";
    echo $(semver_call get major ${VERSION});
}

function semver_get_minor() {
    declare VERSION="${1}";
    echo $(semver_call get minor ${VERSION});
}

function semver_get_patch() {
    declare VERSION="${1}";
    echo $(semver_call get patch ${VERSION});
}

function semver_get_prerel() {
    declare VERSION="${1}";
    echo $(semver_call get prerel ${VERSION});
}

function semver_get_build() {
    declare VERSION="${1}";
    echo $(semver_call get build ${VERSION});
}

function semver_bump_major() {
    declare VERSION="${1}";
    echo $(semver_call bump major ${VERSION});
}

function semver_bump_minor() {
    declare VERSION="${1}";
    echo $(semver_call bump minor ${VERSION});
}

function semver_bump_patch() {
    declare VERSION="${1}";
    echo $(semver_call bump patch ${VERSION});
}

function semver_bump_release() {
    declare VERSION="${1}";
    echo $(semver_call bump release ${VERSION});
}

function semver_bump_prerelease() {
    declare VERSION="${1}";
    declare PREREL="$(semver_build_prerel)";

    if [[ -z "${PREREL}" ]]; then
        echo "Failed to bump the pre-release version. Make sure the currently checked out branch is a pre-release branch." && exit 1;
    fi;

    if [[ -n "$(semver_get_prerel ${VERSION})" ]]; then
        echo "Failed to bump the pre-release version. The current version is already a pre-release version." && exit 1;
    fi;

    echo $(semver_call bump prerel ${PREREL} ${VERSION});
}

function semver_bump_build() {
    declare VERSION="${1}";
    declare BUILD=$(semver_increment_build $(semver_get_build "${VERSION}"));

    echo $(semver_call bump build ${BUILD} ${VERSION});
}

function semver_increment_build() {
    declare -i BUILD=${1}

    if [[ -z "${BUILD}" ]]; then
       BUILD=0
    fi;

    echo $(expr ${BUILD} + 1)
}

function semver_is_valid_version() {
    return $(semver_get_major $1 2>/dev/null) && $(semver_get_minor $1 2>/dev/null) && $(semver_get_patch $1 2>/dev/null);
}

function git_fetch_tags() {
  git fetch --tags;
}

function git_push_tags() {
  git push --tags;
}

function git_get_sorted_tags_list() {
    declare SORT_LEXICOGRAPHIC="refname";
    declare SORT_VERSION="version:refname";

    git tag --sort=${SORT_VERSION};
}

function git_get_last_version() {
    declare PREREL="${1}";

    if [[ -n ${PREREL} ]]; then
        echo "$(git_get_sorted_tags_list | grep ${PREREL} | tail -n 1)";
    else
        echo "$(git_get_sorted_tags_list | tail -n 1)";
    fi;
}

function git_get_last_stable_version() {
    echo "$(git_get_sorted_tags_list | grep -ve "-\|+" | tail -n 1)";
}

function git_get_next_version() {
    declare DEFAULT_VERSION="v0.1.0";
    declare PREREL="$(semver_build_prerel)";
    declare LAST_VERSION="$(git_get_last_version)";
    declare LAST_PREREL_VERSION="$(git_get_last_version ${PREREL})";
    declare LAST_STABLE_VERSION="$(git_get_last_stable_version)";

    if [[ -z ${LAST_VERSION} ]]; then
        LAST_VERSION=${DEFAULT_VERSION};
    fi;

    if [[ -z ${PREREL} ]]
    then
        echo $(semver_bump_patch ${LAST_VERSION}) && exit 0
    else
        if [[ -z ${LAST_PREREL_VERSION} ]]
        then
            echo $(semver_bump_build $(semver_bump_prerelease $(semver_bump_patch ${LAST_VERSION}))) && exit 0;
        else
            echo $(semver_bump_build ${LAST_PREREL_VERSION}) && exit 0;
        fi
    fi;
}

function npm_version() {
    declare NEXT_VERSION="${1}";

    npm version ${NEXT_VERSION};
}

function npm_publish() {
    npm publish --access public;
}
