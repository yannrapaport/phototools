#!/bin/sh
PICTURES="*.DNG *.JPG"
MOVIES="*.MOV"
mkdir 1-capture 2-select 3-master 4-output 10-video
mv $PICTURES 1-capture
mv $MOVIES 10-video
