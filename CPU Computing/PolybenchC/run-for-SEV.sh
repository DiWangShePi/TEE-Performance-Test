#!/bin/bash

THREADS=1
WARMUP=1
EXECUTION=1

output=$(dmesg | grep -i SEV)

if [[ -n "$output" ]]; then
    STATUS="SEV"
else
    STATUS="non-SEV"
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

script_path=$(dirname "$(readlink -f "$0")")
parent_dir=$(basename "$script_path")
echo "We are now executing benchmark: $parent_dir"

target=$parent_dir
# Warm Up
for ((var=0; var<$WARMUP; var++))
do
    { ./$target 2>&1; } >> WarmUpFor$STATUS.output 2>&1
done

# Execute
for ((var=0; var<$EXECUTION; var++))
do
    { ./$target 2>&1; } >> ResultFor$STATUS.output 2>&1
done

