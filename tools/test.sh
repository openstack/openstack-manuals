#!/bin/bash -xe

if [[ -d publish-docs/www/ ]]; then
    output=publish-docs/www
else
    output=publish-docs/
fi

.tox/checkbuild/bin/python tools/www-generator.py --verbose --source-directory www/ \
        --output-directory $output $@

if [[ $? -eq 0 ]]; then
    rsync -a www/static/ $output
fi
# publish-docs/www-index.html is the trigger for openstack-indexpage
# to include the file.
#mv publish-docs/www/www-index.html publish-docs/www-index.html

.tox/checkbuild/bin/whereto $output/.htaccess $output/redirect-tests.txt
