#!/bin/bash -xe

.tox/checkbuild/bin/python tools/www-generator.py --verbose --source-directory www/ \
        --output-directory publish-docs/www/ $@

if [[ $? -eq 0 ]]; then
    rsync -a www/static/ publish-docs/www/
fi
# publish-docs/www-index.html is the trigger for openstack-indexpage
# to include the file.
#mv publish-docs/www/www-index.html publish-docs/www-index.html
