#!/bin/bash

#declare -a arr=(519760)
IFS=' ' read -a arr <<< $1
OUTPUT=$4
: ${OUTPUT:=~/merged}
touch $OUTPUT

for (( i = 0; i < ${#arr[@]} ; i++ )); do
    echo "Merging revision ${arr[$i]}..."
    #svn merge -c ${arr[$i]} svn+ssh://$LF_USER@vcs1/trunk/src .
    svn merge -c ${arr[$i]} $2 $3
    echo "svn merge -c ${arr[$i]} $2 $3" >> $OUTPUT
done
