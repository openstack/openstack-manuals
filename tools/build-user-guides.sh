#!/bin/sh -e

echo "Building End User Guide"
echo "======================="
sphinx-build -t user_only -E -W doc/user-guides/source/ doc/user-guides/build/html
echo "Building Admin User Guide"
echo "========================="
sphinx-build -t admin_only -E -W doc/user-guides/source/ doc/user-guides/build-admin/html

# Cleanup: Rename index-html to index everywhere
mv doc/user-guides/build-admin/html/index-admin.html doc/user-guides/build-admin/html/index.html
sed -i -e 's/index-admin.html/index.html/g' doc/user-guides/build-admin/html/*.html doc/user-guides/build-admin/html/*/*.html
