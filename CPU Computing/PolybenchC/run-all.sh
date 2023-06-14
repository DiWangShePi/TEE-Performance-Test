#!/bin/bash

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

# Define a recursive function to traverse through subdirectories
function traverse_dir {
    for file in "$1"/*; do
        if [[ -d "$file" ]]; then
            traverse_dir "$file"
        else
            if [[ -x "$file" && -f "$file" ]]; then
                # If the file is executable and a regular file, print its name
                # echo "$(basename "$file")"
                NAME="$(basename "$file")"
                DIRPATH="$(dirname "$file")"
                cd $DIRPATH
                echo $PWD
                bash run.sh -t $THREADS -w $WARMUP -e $EXECUTION
                cd /polybench-c-4.2.1-beta
                break
            fi
        fi
    done
}

# Check if an argument was provided and it's a directory
if [[ $# -eq 1 && -d "$1" ]]; then
    # Call the function for the specified directory
    traverse_dir "$1"
else
    echo "Please provide a directory path as an argument."
fi