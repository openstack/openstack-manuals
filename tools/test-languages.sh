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

function test_ja {
    setup_lang 'ja'

    case "$PURPOSE" in
        test)
            setup_directory 'ja' 'high-availability-guide' \
                'install-guide'  'security-guide' 'user-guide' \
                'user-guide-admin'
            openstack-doc-test --check-build -l ja \
                --only-book high-availability-guide \
                --only-book install-guide \
                --only-book user-guide \
                --only-book user-guide-admin \
                --only-book security-guide
            RET=$?
            ;;
        publish-install)
            setup_directory 'ja' 'install-guide'
            openstack-doc-test --publish --check-build -l ja \
                --only-book install-guide
            RET=$?
            ;;
        publish)
            setup_directory 'ja' 'security-guide' 'high-availability-guide'
            openstack-doc-test --publish --check-build -l ja \
                --only-book high-availability-guide \
                --only-book user-guide \
                --only-book user-guide-admin \
                --only-book security-guide
            RET=$?
            ;;
    esac
    if [ "$RET" -eq "0" ] ; then
        echo "... succeeded"
    else
        echo "... failed"
        BUILD_FAIL=1
    fi
}

function test_language () {

    case "$language" in
        ja)
            test_ja
            ;;
        *)
            BUILD_FAIL=1
            echo "Language $language not handled"
            ;;
    esac
}

function usage () {
    echo "Call the script as: "
    echo "$0 PURPOSE LANGUAGE1 LANGUAGE2..."
    echo "PURPOSE is either 'test', 'publish' or 'publish-install'"
}

if [ "$#" -lt 2 ] ; then
    usage
    exit 1
fi
if [ "$1" = "test" ] ; then
   PURPOSE="test"
elif [ "$1" = "publish" ] ; then
   PURPOSE="publish"
elif [ "$1" = "publish-install" ] ; then
   PURPOSE="publish-install"
else
    usage
    exit 1
fi
shift
BUILD_FAIL=0
for language in "$@" ; do
  echo
  echo "Building for language $language"
  echo
  test_language "$language"
done

exit $BUILD_FAIL
