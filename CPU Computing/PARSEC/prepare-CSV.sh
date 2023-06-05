#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
benchmarks=("blackscholes" "bodytrack" "facesim" "ferret" "fluidanimate" "freqmine" "swaptions" "canneal" "dedup" "streamcluster")
performance_dir="$script_dir/performance"

# Handle benchmarks under pkgs/apps
for benchmark in "${benchmarks[@]}"; do
    cp run-for-CSV.sh $performance_dir/$benchmark/
    mv $performance_dir/$benchmark/run-for-CSV.sh $performance_dir/$benchmark/run.sh
done
