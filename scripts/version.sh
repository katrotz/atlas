#!/usr/bin/env bash

VERSION=$1

PATH=$(npm bin):$PATH lerna exec -- rm -rf dist
PATH=$(npm bin):$PATH lerna exec -- npm version ${VERSION}
