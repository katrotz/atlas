#!/usr/bin/env bash

PATH=$(npm bin):$PATH lerna exec -- npm publish --access public
