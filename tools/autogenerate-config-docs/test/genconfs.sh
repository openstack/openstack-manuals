#!/usr/bin/env bash
# vim: tabstop=4 shiftwidth=4 softtabstop=4

proj_list="ceilometer cinder glance keystone nova neutron"
#proj_list="keystone"

for proj in ${proj_list}; do

    cd ${proj};

#        -o ! -path "build/*" \
    FILES=$(find ${proj} -type f -name "*.py" ! -path "${proj}/tests/*" \
        ! -path "build/*" \
        -exec grep -l "Opt(" {} \; | sort -u)

    BINS=$(echo bin/${proj}-* | grep -v ${proj}-rootwrap)
    export EVENTLET_NO_GREENDNS=yes

    PYTHONPATH=./:${PYTHONPATH} \
        python $(dirname "$0")/../generator.py ${FILES} ${BINS} > \
        ../${proj}.conf.sample

    # Remove compiled files created by imp.import_source()
    for bin in ${BINS}; do
        [ -f ${bin}c ] && rm ${bin}c
    done

    cd -

done

