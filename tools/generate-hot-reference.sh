#!/bin/sh -e

# Generates the HOT reference from the heat repository

usage() {
    echo "$0 HEAT_DIR"
}

HEAT_DIR=$1

if [ -z "$1" ]; then
    usage
    exit 1
fi

# generate the doc in the heat directory
(
    cd $HEAT_DIR
    tox -edocs
    . .tox/docs/bin/activate
    make -C doc xml
)

SOURCES="cfn functions openstack"
TARGET=$(dirname $(readlink -f $0))/../doc/hot-reference/generated

for source in $SOURCES; do
    openstack-dn2osdbk $HEAT_DIR/doc/build/xml/template_guide/$source.xml \
        $TARGET/$source.xml
done
