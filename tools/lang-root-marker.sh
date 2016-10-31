#!/bin/bash -xe


# Declare in case it's not in the file
declare -A SPECIAL_BOOKS
declare -A DRAFTS
CONF_FILE=$1
shift

if [[ -z $CONF_FILE ]]; then
    echo "Needs doc-tools-check-languages.conf as only parameter"
    exit 1
fi

source $CONF_FILE

# This marker is needed for Infra publishing and needs to go into the
# root directory of each translated manual as file ".root-marker".
MARKER_TEXT="Project: $ZUUL_PROJECT Ref: $ZUUL_REFNAME Build: $ZUUL_UUID"

INSTALL_TAGS="obs rdo ubuntu"

# openstack-doc-tools 0.34 does not write the marker but we need this
# specific version of the tools
# Write the marker ourselves
for language in "${!BOOKS[@]}"; do
    for book in ${BOOKS["$language"]}; do
        if [ ${book} = "install-guide" ] ; then
            for tag in $INSTALL_TAGS; do
                PUBLISH_DIR=publish-docs/liberty/${language}/${book}-${tag}
                echo $MARKER_TEXT > ${PUBLISH_DIR}/.root-marker
            done
        else
            PUBLISH_DIR=publish-docs/liberty/${language}/${book}/
            echo $MARKER_TEXT > ${PUBLISH_DIR}/.root-marker
        fi
    done
done
