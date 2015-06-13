#!/bin/bash -xe
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

DIRECTORY=$1

if [ -z "$DIRECTORY" ] ; then
    echo "usage $0 DIRECTORY options"
    echo "Options are:"
    echo "--glossary: Build glossary"
    echo "--tag TAG: Use given tag for building"
    echo "--target TARGET: Copy files to publish-docs/$TARGET"
    echo "--build BUILD: Name of build directory"
    exit 1
fi

GLOSSARY=0
TARGET=""
TAG=""
TAG_OPT=""
BUILD=""

while [[ $# > 1 ]] ; do
    option="$1"
    case $option in
        --glossary)
            GLOSSARY=1
            ;;
        --tag)
            TAG="$2"
            TAG_OPT="-t $2"
            shift
            ;;
        --target)
            TARGET="$2"
            shift
            ;;
        --build)
            BUILD="$2"
            shift
            ;;
    esac
    shift
done


if [ "$GLOSSARY" -eq "1" ] ; then
    echo "Generating Glossary"
    tools/glossary2rst.py doc/common-rst/glossary.rst
fi

if [ -z "$BUILD" ] ; then
    if [ -z "$TAG" ] ; then
        BUILD_DIR="$DIRECTORY/build/html"
    else
        BUILD_DIR="$DIRECTORY/build-${TAG}/html"
    fi
else
    BUILD_DIR="$DIRECTORY/$BUILD/html"
fi

sphinx-build -E -W $TAG_OPT $DIRECTORY/source $BUILD_DIR

# Copy RST
if [ "$TARGET" != "" ] ; then
    mkdir -p publish-docs/$TARGET
    rsync -a $BUILD_DIR/ publish-docs/$TARGET/
fi
