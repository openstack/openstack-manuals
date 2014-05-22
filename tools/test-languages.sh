#!/bin/bash

function setup_directory {
    SET_LANG=$1
    shift
    for BOOK_DIR in "$@" ; do
        openstack-generate-docbook -l $SET_LANG -b $BOOK_DIR
    done
}


function setup_lang {
    SET_LANG=$1
    shift
    echo "Setting up files for $SET_LANG"
    echo "======================="
    setup_directory $SET_LANG 'common' 'glossary' "$@"
    cp doc/pom.xml generated/$SET_LANG/pom.xml
}

function test_manuals {
    SET_LANG=$1
    shift
    for BOOK in "$@" ; do
        echo "Building $BOOK for language $SET_LANG..."
        setup_directory $SET_LANG $BOOK
        openstack-doc-test --check-build -l $SET_LANG --only-book $BOOK
        RET=$?
        if [ "$RET" -eq "0" ] ; then
            echo "... succeeded"
        else
            echo "... failed"
            BUILD_FAIL=1
        fi
    done
}

function test_ja {
    setup_lang 'ja'
    test_manuals 'ja' 'security-guide' 'high-availability-guide' 'install-guide'
}


BUILD_FAIL=0
test_ja

exit $BUILD_FAIL
