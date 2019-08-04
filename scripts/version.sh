#!/usr/bin/env bash

PATH=$(npm bin):$PATH lerna version patch --yes --amend --include-merged-tags --no-changelog --tag-version-prefix='v'
