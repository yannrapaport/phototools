#!/bin/sh

#  ptt-lib.inc.sh
#  
#
#  Created by Yann Rapaport on 30/07/2018.
#  

PICTURES="*.DNG *.JPG *.CR2"
MOVIES="*.MOV"
DIRS="1-capture 2-select 3-master 4-output 10-video"

debug() {
    if $DEBUG; then
        echo $1
    fi
}
