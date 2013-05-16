#!/bin/bash

# Usage:
# svnmerge.sh '123 456' server working_copy

IFS=' ' read -a arr <<< $1
OUTPUT=$4
: ${OUTPUT:=~/merged}
touch $OUTPUT

for (( i = 0; i < ${#arr[@]} ; i++ )); do
    echo "Merging revision ${arr[$i]}..."
    svn merge -c ${arr[$i]} $2 $3
    echo "svn merge -c ${arr[$i]} $2 $3" >> $OUTPUT
done
