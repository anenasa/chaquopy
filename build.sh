#!/bin/bash
# Gradle 7.0.2 does not support new version of java
if [ -n "$JAVA_HOME_11" ]; then
    export JAVA_HOME="$JAVA_HOME_11"
fi
echo "java location is $JAVA_HOME/bin"
export JAVA_VERSION=$($JAVA_HOME/bin/javac -version 2>&1 | awk '{print $2}'| awk -F. '{print ($1 == "1" ? $2 : $1)}')
if [ "$JAVA_VERSION" -ne 11 ]; then
    echo "Java version $JAVA_VERSION is not supported. Please use Java 11."
    exit 1
fi
# Avoid installing to lib64 instead of lib
export CONFIG_SITE=/dev/null
cd target
./python/build-and-package.sh 3.13
cd ../product
./gradlew --no-daemon publish -P cmakeBuildType=Release
