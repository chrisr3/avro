#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

case "$TRAVIS_OS_NAME" in
"linux")
    sed -i.bak "s/openjdk:8/openjdk:${JAVA}/" share/docker/Dockerfile
    /tmp/yetus-0.8.0/bin/test-patch --plugins=buildtest --java-home=/usr/local/openjdk-"${JAVA}" --user-plugins=share/precommit/ --run-tests --empty-patch --docker --dockerfile=share/docker/Dockerfile --dirty-workspace --verbose=true
    ;;
"windows")
    ./lang/csharp/build.sh test
    ;;
*)
    echo "Invalid PLATFORM"
    exit 1
    ;;
esac