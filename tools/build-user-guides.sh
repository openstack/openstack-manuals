#!/bin/sh -e

tools/build-rst.sh doc/user-guide --glossary --tag user_only --build build
# No need to build the glossary again here.
tools/build-rst.sh doc/user-guide-admin --tag admin_only --build build
