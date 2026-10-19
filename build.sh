#!/bin/bash
cd target
./python/build-and-package.sh 3.12
cd ../product
if [ -n "$JAVA_HOME_11" ]; then
    export JAVA_HOME="$JAVA_HOME_11"
elif [ -n "$JAVA_HOME_8" ]; then
    export JAVA_HOME="$JAVA_HOME_8"
fi
./gradlew publish -P cmakeBuildType=Release
