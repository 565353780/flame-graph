#!/bin/sh

PID=$(pgrep ${1})

if [ -z "${PID}" ]; then
    echo '[ERROR][track.sh]'
    echo '\t input process not exist!'
    exit 1
fi

if [ -z "${2}" ]; then
    echo '[ERROR][track.sh]'
    echo '\t need to input tracking time!'
    exit 1
fi

mkdir output
cd output

rm -f perf-${1}*
perf record -F 99 -p $PID -g -o perf-${1}-in-fb.data -- sleep ${2}
perf script -i perf-${1}-in-fb.data &> perf-${1}.unfold
stackcollapse-perf-pl perf-${1}.unfold &> perf-${1}.folded
flamegraph.pl perf-${1}.folded > perf-${1}.svg
