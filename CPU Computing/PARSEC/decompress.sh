#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_dir="$script_dir/pkgs"
target_dir="$script_dir/performance"
input_dir="inputs"
# swaptions and streamcluster component does not need input
app_benchmarks=("blackscholes" "bodytrack" "facesim" "ferret" "fluidanimate" "freqmine" "swaptions")
kernel_benchmarks=("canneal" "dedup" "streamcluster")

performance_dir="$script_dir/performance"

# Check if "performance" directory exists and delete it if found
if [ -d "$performance_dir" ]; then
  echo "Removing existing performance directory..."
  sudo rm -rf "$performance_dir"
fi

sudo mkdir performance
cd "$target_dir"

size=simmedium

while getopts ":s:" opt
do
    case $opt in
        s)
            size=$OPTARG
            if [[ "$size" != "native" && "$size" != "simdev" && "$size" != "simlarge" && "$size" != "simmedium" && "$size" != "simsmall" && "$size" != "test" ]]; then
                echo "Invalid config: $size"
                exit 1
            fi
            ;;
        ;;
        ?)
        echo "Unknown parameter"
        exit 1;;
esac done

cd "$target_dir" || exit 1

# Handle benchmarks under pkgs/apps
for benchmark in "${app_benchmarks[@]}"; do
    if ! sudo mkdir "$benchmark"; then
        echo "Failed to create directory: $benchmark"
        exit 1
    fi


    if ! sudo cp "$source_dir/apps/$benchmark/inst/amd64-linux.gcc-hooks/bin/"* "$target_dir/$benchmark"; then
        echo "Failed to copy files for benchmark: $benchmark"
        exit 1
    fi

    if ! sudo cp "$source_dir/apps/$benchmark/parsec/$size.runconf" "$target_dir/$benchmark"; then
        echo "Failed to copy command for benchmark: $benchmark"
        exit 1
    fi

    if [ "$benchmark" != "swaptions" ]; then
        cd "$source_dir/apps/$benchmark/$input_dir" || exit 1
        if ! tar -xvf "input_$size.tar" -C "$target_dir/$benchmark"; then
            echo "Failed to extract input files for benchmark: $benchmark"
            exit 1
        fi
    fi

    cd "$target_dir" || exit 1
    echo $PWD
done

cd "$target_dir"

# Handle benchmarks under pkgs/kernels
for benchmark in "${kernel_benchmarks[@]}"; do
    if ! sudo mkdir "$benchmark"; then
        echo "Failed to create directory: $benchmark"
        exit 1
    fi


    if ! sudo cp "$source_dir/kernels/$benchmark/inst/amd64-linux.gcc-hooks/bin/"* "$target_dir/$benchmark"; then
        echo "Failed to copy files for benchmark: $benchmark"
        exit 1

    fi
  
    if ! sudo cp "$source_dir/kernels/$benchmark/parsec/$size.runconf" "$target_dir/$benchmark"; then
        echo "Failed to copy command for benchmark: $benchmark"
        exit 1
    fi

    if [ "$benchmark" != "streamcluster" ]; then
        cd "$source_dir/kernels/$benchmark/$input_dir" || exit 1
        if ! tar -xvf "input_$size.tar" -C "$target_dir/$benchmark"; then
            echo "Failed to extract input files for benchmark: $benchmark"
            exit 1
        fi
    fi

    cd "$target_dir" || exit 1
done
