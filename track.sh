#!/bin/sh

PID=$(pgrep ${1})

if [ -z "${PID}" ]; then
	echo '[ERROR][track.sh]'
	echo '\t input process not exist!'
	exit 1
fi

mkdir output
cd output

rm -rf ${1}
mkdir ${1}
cd ${1}

perf record -F 99 -p $PID -g -o perf-in-fb.data -- sleep 60
perf script -i perf-in-fb.data >perf.unfold
../../../FlameGraph/stackcollapse-perf.pl perf.unfold >perf.folded
../../../FlameGraph/flamegraph.pl perf.folded >perf.svg
