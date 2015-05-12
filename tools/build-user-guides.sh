#!/bin/sh -e

tools/build-rst.sh doc/user-guide --glossary --build build
# No need to build the glossary again here.
tools/build-rst.sh doc/user-guide-admin --build build
