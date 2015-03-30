#!/bin/sh -e

echo "Building End User Guide"
echo "======================="
sphinx-build -t user_only -E -W doc/playground-user-guide/source/ doc/playground-user-guide/build/html
echo "Building Admin User Guide"
echo "========================="
sphinx-build -t admin_only -E -W doc/playground-user-guide/source/ doc/playground-user-guide/build-admin/html

# Cleanup: Rename index-html to index everywhere
mv doc/playground-user-guide/build-admin/html/index-admin.html doc/playground-user-guide/build-admin/html/index.html
sed -i -e 's/index-admin.html/index.html/g' doc/playground-user-guide/build-admin/html/*.html doc/playground-user-guide/build-admin/html/*/*.html
