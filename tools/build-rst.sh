#!/bin/bash -e
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
    echo "--tag TAG: Use given tag for building"
    echo "--target TARGET: Copy files to publish-docs/$TARGET"
    echo "--build BUILD: Name of build directory"
    echo "--linkcheck: Check validity of links instead of building"
    echo "--pdf: PDF file generation"
    exit 1
fi

TARGET=""
TAG=""
TAG_OPT=""
BUILD=""
LINKCHECK=""
PDF=""

while [[ $# > 0 ]] ; do
    option="$1"
    case $option in
        --build)
            BUILD="$2"
            shift
            ;;
        --linkcheck)
            LINKCHECK=1
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
        --pdf)
            PDF=1
            ;;
    esac
    shift
done


if [ -z "$BUILD" ] ; then
    if [ -z "$TAG" ] ; then
        BUILD_DIR="$DIRECTORY/build/html"
        BUILD_DIR_PDF="$DIRECTORY/build/pdf"
    else
        BUILD_DIR="$DIRECTORY/build-${TAG}/html"
        BUILD_DIR_PDF="$DIRECTORY/build-${TAG}/pdf"
    fi
else
    BUILD_DIR="$DIRECTORY/$BUILD/html"
    BUILD_DIR_PDF="$DIRECTORY/$BUILD/pdf"
fi

DOCTREES="${BUILD_DIR}.doctrees"

if [ -z "$TAG" ] ; then
    echo "Checking $DIRECTORY..."
else
    echo "Checking $DIRECTORY with tag $TAG..."
fi

if [ "$LINKCHECK" = "1" ] ; then
    # Show sphinx-build invocation for easy reproduction
    set -x
    sphinx-build -E -W -d $DOCTREES -b linkcheck \
        $TAG_OPT $DIRECTORY/source $BUILD_DIR
    set +x
else
    # Show sphinx-build invocation for easy reproduction
    set -x
    sphinx-build -E -W -d $DOCTREES -b html \
        $TAG_OPT $DIRECTORY/source $BUILD_DIR
    set +x

    # PDF generation
    if [ "$PDF" = "1" ] ; then
        set -x
        sphinx-build -E -W -d $DOCTREES -b latex \
            $TAG_OPT $DIRECTORY/source $BUILD_DIR_PDF
        make -C $BUILD_DIR_PDF
        cp $BUILD_DIR_PDF/*.pdf $BUILD_DIR/
        set +x
    fi

    # Copy RST (and PDF)
    if [ "$TARGET" != "" ] ; then
        mkdir -p publish-docs/$TARGET
        rsync -a $BUILD_DIR/ publish-docs/$TARGET/
        # Remove unneeded build artefact
        rm -f publish-docs/$TARGET/.buildinfo
    fi
fi
