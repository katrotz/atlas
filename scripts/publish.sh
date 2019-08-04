#!/usr/bin/env bash

PATH=$(npm bin):$PATH lerna version patch --yes --amend --include-merged-tags --no-changelog --no-push --tag-version-prefix='v'

PATH=$(npm bin):$PATH lerna publish from-git --yes --dist-tag latest --pre-dist-tag next
