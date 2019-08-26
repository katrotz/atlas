#!/usr/bin/env bash

set -e

GITHUB_USER="katrotz";
GITHUB_REPO="atlas";
NPM_REGISTRY="registry.npmjs.org";

if [[ -n ${GITHUB_TOKEN} ]]; then
    git remote set-url origin https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${GITHUB_REPO}.git;
    git config --global user.name "CI Server";
    git config --global user.email "travis@example.com";
else
    echo "Expected the environment variable \$GITHUB_TOKEN to be set" && exit 1;
fi

if [[ -n ${NPM_TOKEN} ]]; then
    touch ~/.npmrc;
    echo "//${NPM_REGISTRY}/:_authToken=${NPM_TOKEN}" >> ~/.npmrc;
else
    echo "Expected the environment variable \$NPM_TOKEN to be set" && exit 1;
fi
