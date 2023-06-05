#!/bin/bash

THREADS=1
WARMUP=1
EXECUTION=1

output=$(dmesg | grep -i SEV)

if [[ -n "$output" ]]; then
    STATUS="CSV"
else
    STATUS="non-CSV"
fi

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


run_args=$(grep -m 1 "^run_args" *.runconf | cut -d "=" -f 2)
run_args=$(echo "${run_args}" | sed "s/\${NTHREADS}/${THREADS}/g")
run_args="${run_args//\"/}"
export OMP_NUM_THREADS=$THREADS

script_path=$(dirname "$(readlink -f "$0")")
parent_dir=$(basename "$script_path")
echo "We are now executing benchmark: $parent_dir"

target=$parent_dir
# Warm Up
for ((var=0; var<$WARMUP; var++))
do
    { ./$target $run_args 2>&1; } >> WarmUpFor$STATUS.output 2>&1
done

# Execute
for ((var=0; var<$EXECUTION; var++))
do
    { ./$target $run_args 2>&1; } >> ResultFor$STATUS.output 2>&1
done

