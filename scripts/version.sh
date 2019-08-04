#!/usr/bin/env bash

VERSION=$1

PATH=$(npm bin):$PATH lerna exec -- npm version ${VERSION}
#PATH=$(npm bin):$PATH lerna version patch --yes --amend --include-merged-tags --no-changelog --tag-version-prefix='v'
