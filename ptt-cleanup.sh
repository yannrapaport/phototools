#!/bin/sh

#  ptt-cleanup.sh
#  
#
#  Created by Yann Rapaport on 30/07/2018.
#  
source $(dirname $0)/ptt-lib.inc

for d in $(find $DIRS -empty 2>/dev/null); do
  RM_DIRS="$d $RM_DIRS"
done

echo "The following dirs are empty and will be removed:"
echo $RM_DIRS
echo "Continue (Y/n)?"
read ans

case $ans in
    n|N)    exit;;
    ""|Y|y) rm -rf $RM_DIRS;;
    *)      echo "Unrecognized answer $ans";;
esac
