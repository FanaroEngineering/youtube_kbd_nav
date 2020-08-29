#!/bin/bash

BUILD_DIR="build"

if [[ ! -e $BUILD_DIR ]]; then
    mkdir $BUILD_DIR
fi

dart2js --csp -O4 -o build/content.dart.js web/content.dart

cp web/manifest.json build

zip -r build.zip build 