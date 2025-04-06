#!/bin/bash
mkdir -p /root/.ssh
cd /workspace/develop
./gradlew build
./gradlew idea --no-configuration-cache
