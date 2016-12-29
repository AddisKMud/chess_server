#!/bin/bash

git status -s | awk '{print $2}' | grep '\.lua' | xargs luacheck
