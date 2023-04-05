#!/bin/sh
source $(dirname $0)/ptt-lib.inc

mkdir $DIRS
mv $PHOTOS 1-photos 2>/dev/null
mv $VIDEOS 1-videos 2>/dev/null
