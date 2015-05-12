#!/bin/sh -e

tools/build-rst.sh doc/user-guides --glossary --tag user_only --build build
# No need to build the glossary again here.
tools/build-rst.sh doc/user-guides --tag admin_only --build build-admin

# Cleanup: Rename index-html to index everywhere
mv doc/user-guides/build-admin/html/index-admin.html doc/user-guides/build-admin/html/index.html
sed -i -e 's/index-admin.html/index.html/g' doc/user-guides/build-admin/html/*.html doc/user-guides/build-admin/html/*/*.html
