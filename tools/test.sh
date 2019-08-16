#!/bin/bash -xe

if [[ -d publish-docs/html/www/ ]]; then
    output=publish-docs/html/www
else
    output=publish-docs/html/
fi

.tox/publishdocs/bin/python tools/www-generator.py --verbose --source-directory www/ \
        --output-directory $output $@

if [[ $? -eq 0 ]]; then
    rsync -a www/static/ $output
fi
# publish-docs/html/www-index.html is the trigger for openstack-indexpage
# to include the file.
#mv publish-docs/html/www/www-index.html publish-docs/html/www-index.html

.tox/publishdocs/bin/whereto $output/.htaccess $output/redirect-tests.txt
