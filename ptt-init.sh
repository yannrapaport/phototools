#!/bin/sh
source $(dirname $0)/ptt-lib.inc

mkdir $DIRS
mv $PICTURES 1-capture 2>/dev/null
mv $MOVIES 10-video 2>/dev/null
