#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/parsec-3.0/pkgs/libs/hooks/inst/amd64-linux.gcc-hooks/lib

THREADS=1
WARMUP=1
EXECUTION=1

while getopts ":t:w:e:" opt
do
    case $opt in
        t)
            THREADS=$OPTARG
        ;;
        w)
            WARMUP=$OPTARG
        ;;
        e)
            EXECUTION=$OPTARG
        ;;
        ?)
        echo "Unknown parameter"
        exit 1;;
esac done

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
benchmarks=("blackscholes" "bodytrack" "facesim" "ferret" "fluidanimate" "freqmine" "swaptions" "canneal" "dedup" "streamcluster")
performance_dir="$script_dir/performance"

# Handle benchmarks under pkgs/apps
for benchmark in "${benchmarks[@]}"; do
    cd $performance_dir/$benchmark
    bash run.sh -t $THREADS -w $WARMUP -e $EXECUTION
    cd $script_dir
done